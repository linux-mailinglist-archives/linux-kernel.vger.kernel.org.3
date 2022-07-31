Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E795586069
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiGaSre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGaSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:47:29 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA6DF6A;
        Sun, 31 Jul 2022 11:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659293214; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=VMtZTlZqTpIyiVgpkxvDTwe/5hDJ5qiZzIN+CYThyu+b1oOBOMk+xvSBiB7SY/inhuFbMnx156X/Er9T8DTWf+AKvQwLC5GYo+gRSiF+AwNrI5KDHcAHJXYn9lS5PX18k9g3COaEmxLj8bvMJ0V3dnd64gLOUz0QRB26XVo7zpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659293214; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Uj4glfeT9Z7nH5oo3H/JP4uyo13D+BpPuLlcPeEcVE0=; 
        b=cbFVMWjHuh+2Tbvv+yheSdv8Rsv4rCdwAUpwnXajeTpSVXcmZPKY6d5bC6yPXFaWCkqfF1QXem9bTZF2qhp417JRgIgHqHQ2PwERbmapIY0J4go9lS5PyOj9/cG2VIPk8fVk3ze0GgFxhEbEA1jL+NkV7zdhF/wW0ozu5UwukzM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659293214;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Uj4glfeT9Z7nH5oo3H/JP4uyo13D+BpPuLlcPeEcVE0=;
        b=GGC6NTSC74sqGG+ekDg5O9aXSNSdgGaBexWLPVoO1uzC5640kYibHqavkoUyeBM/
        rQvW3e7LueMbBxio0QfREfJW3AjnDLqD3//LQ3p5o+/w463Lmsleam1dQxN01R+5IYO
        frk8Rf34MWUGr/KplwnIA7j9c5s8qXmSg2GrlC6A=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659293203918386.25370840011624; Mon, 1 Aug 2022 00:16:43 +0530 (IST)
Date:   Mon, 01 Aug 2022 00:16:43 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "Marius Fleischer" <fleischermarius@googlemail.com>,
        "Priyanka Bose" <its.priyanka.bose@gmail.com>
Message-ID: <1825594fdb6.52eb2a02235647.5426665702277259900@siddh.me>
In-Reply-To: <20220731181131.GB3569921@berlinger>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
 <20220723135447.199557-1-code@siddh.me>
 <Ytv/4Tljvlt0PJ2r@kroah.com>
 <3558070.1658933200@warthog.procyon.org.uk>
 <182407602ce.190e58816827.7904364186178466266@siddh.me> <20220731181131.GB3569921@berlinger>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 23:41:31 +0530  Dipanjan Das <mail.dipanjan.das@gmail.c=
om> wrote:
> On Wed, Jul 27, 2022 at 09:50:52PM +0530, Siddh Raman Pant wrote:
> > Thank you for explaining it!
> >=20
> > I will send a v3. Should I add a Suggested-by tag mentioning you?
>=20
> Sorry for jumping in.
>=20
> We have reported the same bug in kernel v5.10.131 [https://lore.kernel.or=
g/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com]. =
We have been suggested to join this discussion so that we can have appropri=
ate meta-information injected in this patch=E2=80=99s commit message to mak=
e sure that it gets backported to v5.10.y.  Therefore, we would like to be =
in the loop so that we can offer help in the process, if needed.
>=20

As you are suggesting for backporting, I should CC the stable list, or mail
after it gets merged. You have reproduced it on v5.10, but the change seems=
 to
be introduced by c73be61cede5 ("pipe: Add general notification queue suppor=
t"),
which got in at v5.8. So should it be backported till v5.8 instead?

I actually looked this up on the internet / lore now for any other reports,=
 and
it seems this fixes a CVE (CVE-2022-1882).

The reporter of CVE seems to have linked his patch as a part of CVE report,=
 of
which he sent v2, but he seems to do it in a roundabout way, and also in a =
way
similar to what Hillf Danton had replied to my v2 patch, wherein he missed
353f7988dd84 ("watchqueue: make sure to serialize 'wqueue->defunct' properl=
y"),
so I guess I can propose my patch as a fix for the CVE.

Note: I have already sent the v3, so please suggest any new improvements et=
c.
(except replying to the conversation here) to the v3, which can be found he=
re:
https://lore.kernel.org/linux-kernel/20220728155121.12145-1-code@siddh.me/

Also, you may want to break text into multiples lines instead of one huge l=
ine.

Thanks,
Siddh
