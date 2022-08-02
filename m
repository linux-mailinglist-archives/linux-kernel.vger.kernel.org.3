Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052E588416
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiHBWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHBWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:15:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594FDFA0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:15:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v3so18525790wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=te5wUeGLhF3nWkigofz03L7C8EoefvpKcxV1mA0vXXY=;
        b=6g/wHFujdV6ZhryoRuc16wJv6yZoi5OEWuBrrww7dK47p8omkeJfYKdiJtAtWdKQBE
         nEiZPCP2iRylTHHy0y+UH6T4nTxQi+Gv81uA8azJ0Ucn5lM0DFH37G7v7agI3QnkdHxj
         bJUHkP1CyJ0OWxI3tiMfsocgStifvciDBDmJrUxqBg4cHHJrPJZ5r4rEXFfDD6qwy/U3
         pCPVISDIMyWujSDuPwRF76Ehd6YY+MmqPRFpDtEYrY4mE5s4wPiDqMPidoBNzxUqYZsh
         Af9SDa61I7GiWbnorAiWOdBZ6Y6rWaaUbS9oesEZSB+Z1wi2O/7e67PfigTOW9e+atpQ
         XltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=te5wUeGLhF3nWkigofz03L7C8EoefvpKcxV1mA0vXXY=;
        b=DUZ6yQUQKmGOpigCxpFfpzTBDhRJz9hENAk0+IwowlVmoyt02kC2HiU2Flrf9MAFY1
         nSOEdE5blhl5RjceIqg6sYn1umH8QlQ60YIc+G1Cn+QlyUjbwnXIzu6Xfdb/dY3uFOJK
         mReoDTF3lYjLinWv7RDSwVmFm6n0QGm9HGfa/VAl3QP8wxmuBy8lrBJZdbcXsEh4Zq9o
         vghfGCZJxyD+LR+h6haPTYrXjsRWaMfr1JkCjxoXOT9BRTkZjvJOHPtSVIdyAIW7Wpgp
         nkp5gnwg4mbMifKVuXG+Y40E5ahmIngiwMPC1vdKckiQMch60/EpxDroVj0Wik1lhk+/
         iBLA==
X-Gm-Message-State: ACgBeo0tfT5skap/DvfvjVzDE0LxxowpSQyrbUZPjjkw8NhIyZlRWy3i
        vmbvGIwzsoGtIERC2iZlMp6j4g==
X-Google-Smtp-Source: AA6agR5Q2oxb04fLypbaaOJycRgYEjlbfHiP9K0j/xrCe7RGQAt57BLcV73od3J2TRMq0qgwRMTEdw==
X-Received: by 2002:a05:6000:5ca:b0:220:78de:1c39 with SMTP id bh10-20020a05600005ca00b0022078de1c39mr927810wrb.524.1659478519215;
        Tue, 02 Aug 2022 15:15:19 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id bg7-20020a05600c3c8700b003a3186fa559sm61768wmb.29.2022.08.02.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:15:18 -0700 (PDT)
Date:   Tue, 2 Aug 2022 23:15:16 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, martin@kaiser.cx,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <Yumh9NLeDAMJBJ48@equinox>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
 <2e838551-e6a3-df5d-a889-baf60c7f99fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e838551-e6a3-df5d-a889-baf60c7f99fd@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:10:21PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> Phillip Potter <phil@philpotter.co.uk> says:
> > -	if (!rtw_set_802_11_add_wep(padapter, &wep)) {
> > +	if (rtw_set_802_11_add_wep(padapter, &wep)) {
> >   		if (rf_on == pwrpriv->rf_pwrstate)
> >   			ret = -EOPNOTSUPP;
> >   		goto exit;
> 
> is it intentional to ignore an error in case of rf_on !=
> pwrpriv->rf_pwrstate?
> 
> 

Hi Pavel,

Somewhat yes, in the sense that this is existing behaviour and changing
it is a semantic change in the driver, thus arguably outside the scope
of a patch/patch set that is intended to just focus on error code
handling (moving from _SUCCESS/_FAIL to 0 and -EWHATEVER).

Not fixed to that by any means though, if you would prefer it be
restructured as well. I need to do a V2 for this anyway.

Regards,
Phil
