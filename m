Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050F1586014
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiGaRNE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 31 Jul 2022 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:13:02 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE41BC09
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:13:01 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id E132C1A06CC;
        Sun, 31 Jul 2022 17:12:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 109C719;
        Sun, 31 Jul 2022 17:12:56 +0000 (UTC)
Message-ID: <f93d3ea32ac04a5edd8159abcb0504f71fe7aee4.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
From:   Joe Perches <joe@perches.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sun, 31 Jul 2022 10:12:56 -0700
In-Reply-To: <YuV452xuR1S0WyJi@OEMBP14.local>
References: <20220728231150.972-1-phil@philpotter.co.uk>
         <20220728231150.972-3-phil@philpotter.co.uk> <20220729064803.GT2338@kadam>
         <YuV452xuR1S0WyJi@OEMBP14.local>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 109C719
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Stat-Signature: 4a7yuztp7sn1a8ou8bq714ogqwo51tcy
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1920Q3wvMO6LZXRhz1V+zVQuvrxQfkgkjk=
X-HE-Tag: 1659287576-312776
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-30 at 19:36 +0100, Phillip Potter wrote:
> On Fri, Jul 29, 2022 at 09:48:03AM +0300, Dan Carpenter wrote:
> > On Fri, Jul 29, 2022 at 12:11:50AM +0100, Phillip Potter wrote:
> > > -u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > > +int rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > >  {
> > >  	int		keyid, res;
> > >  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> > > -	u8		ret = _SUCCESS;
> > > +	int		ret = 0;
> > >  
> > >  	keyid = wep->KeyIndex & 0x3fffffff;
> > >  
> > >  	if (keyid >= 4) {
> > > -		ret = false;
> > > +		ret = -EOPNOTSUPP;
> > >  		goto exit;
> > >  	}
> > >  
> > > @@ -424,7 +424,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > >  	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
> > >  
> > >  	if (res == _FAIL)
> > > -		ret = false;
> > > +		ret = -ENOMEM;
> > >  exit:
> > >  
> > >  	return ret;
> > 
> > No, this isn't right.  This now returns 1 on success and negative
> > error codes on error.
> > 
> > There are a couple anti-patterns here:
> > 
> > 1) Do nothing gotos
> > 2) Mixing error paths and success paths.
> > 
> > If you avoid mixing error paths and success paths then you get a pattern
> > called: "Solid return zero."  This is where the end of the function has
> > a very chunky "return 0;" to mark that it is successful.  You want that.
> > Some people do a "if (ret == 0) return ret;".  Nope.  "return ret;" is
> > not chunky.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Hi Dan,
> 
> Thank you for the review firstly, much appreciated.
> 
> I'm happy of course to rewrite this to address any concerns, but
> I was hoping I could clarify what you've said though? Apologies if I've
> missed it, but how is this function now returning 1 on success? It sets
> ret to 0 (success) at the start and then sets it to one of two negative
> error codes depending on what happens. Am I missing something here?
> (Perfectly possible that I am).
> 
> In terms of do nothing gotos, do you mean gotos that just set an error
> code then jump to the end? If you'd prefer, as the function just returns
> right after the exit label, I can just return the codes directly and have
> a 'return 0;' like you say above?
> 
> Thanks as always for your insight.

Yes, you've got it right.

I think Dan is suggesting something like the below, but
not necessarily in a single patch:
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 38 ++++++++++++----------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 17f6bcbeebf42..2736bbce83b5b 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -390,44 +390,38 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	return ret;
 }
 
-u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
+int rtw_set_802_11_add_wep(struct adapter *padapter,
+			   struct ndis_802_11_wep *wep)
 {
-	int		keyid, res;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	u8		ret = _SUCCESS;
+	int keyid;
+	struct security_priv *secpriv = &padapter->securitypriv;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
-
-	if (keyid >= 4) {
-		ret = false;
-		goto exit;
-	}
+	if (keyid >= 4)
+		return -EOPNOTSUPP;
 
 	switch (wep->KeyLength) {
 	case 5:
-		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
+		secpriv->dot11PrivacyAlgrthm = _WEP40_;
 		break;
 	case 13:
-		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
+		secpriv->dot11PrivacyAlgrthm = _WEP104_;
 		break;
 	default:
-		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+		secpriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		break;
 	}
 
-	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0], &wep->KeyMaterial, wep->KeyLength);
+	memcpy(secpriv->dot11DefKey[keyid].skey, &wep->KeyMaterial,
+	       wep->KeyLength);
 
-	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
+	secpriv->dot11DefKeylen[keyid] = wep->KeyLength;
+	secpriv->dot11PrivacyKeyIndex = keyid;
 
-	psecuritypriv->dot11PrivacyKeyIndex = keyid;
+	if (rtw_set_key(padapter, secpriv, keyid, 1) == _FAIL)
+		return -ENOMEM;
 
-	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
-
-	if (res == _FAIL)
-		ret = false;
-exit:
-
-	return ret;
+	return 0;
 }
 
 /*

