Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507DB4F0213
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiDBNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiDBNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:24:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A90173F4D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 06:22:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so7880896wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM1qv869mLVj0L15vUr24+B+GszxmRptC2PdqnBJ5K4=;
        b=SlUPIUKCXurYXUIrs3NwfGg0Q69oEQSC4nOx9sE0oKSjX80eII/DdEotFI3Bsbtvtu
         l3jr+SAkdZKyZMX49mQuH0CLAd9dv8kunEEmIrXttd113lXE7z5xMzayFiJ0fHkWqOAb
         TUP8L74xzEv2V1T43r0FZtVnZ3NLmx5MDGJDpKHf/9VQ9gU677ca+83lObYF6iyLdksJ
         d1WoSgAvcktQuGOqpMOZWuFeZZ/56PcyVAAJ7kY4ejRYSbd9WcmJlU4wpnViOyC38fa9
         hKW+fbSCyf7eyAvikq8Ane9Fd0m9j9NFJe1p5IQxW+CNWF+WGGsIFkVWN2n7GzsUw6AL
         jYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM1qv869mLVj0L15vUr24+B+GszxmRptC2PdqnBJ5K4=;
        b=KUWsWewBVxi2xgxPxx/8LULZOVWqVXFkc2bwQrMf+8oJogyMzMayuD1zyP+ekanvz/
         lyUYJe5R3uwk3hXLIyWOABjKzFE3gx6gA7Ac4ueBcWdWSk8fojrAYOXoQfvYLL3+L9UH
         El7cXZHXnWLofuonCGQ0IlB8Eea85cN1g4YNzugT7iwVC50LFKPCpfuqK6ldSjlOSCrU
         ZEwsTIIDE3d0I+rqAvEib2oGmnWucMuRbnKyfFslaJ7yK+vIkoD0kyuZbLKrd8SjsCMQ
         Cwjs8By2IEZQ9+UJYS7mFnrxZXOGynFhhrGkK7tf4r4RiN1HTHAFu/59TNRr9GkRAItd
         dyEw==
X-Gm-Message-State: AOAM5325rDTS4UobWFxTqdyFQOWPJjb9FGa+HMhhFl/28uFo1aInOUeS
        oFxe/UiZtpyodcM5K5QA6Pc=
X-Google-Smtp-Source: ABdhPJxm8EUnxXG3nVLRw1XHSCkv+pnaG7kBoIk60raQSsyVXx7drDSOToewaHuiVxNmCbBNEkL6aw==
X-Received: by 2002:a05:6000:1e16:b0:206:40c:872d with SMTP id bj22-20020a0560001e1600b00206040c872dmr2204783wrb.535.1648905746951;
        Sat, 02 Apr 2022 06:22:26 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600015cf00b00203e324347bsm5530402wry.102.2022.04.02.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 06:22:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Date:   Sat, 02 Apr 2022 15:22:23 +0200
Message-ID: <2108195.Mh6RI2rZIc@leap>
In-Reply-To: <Ykg3Xfb4vjjGSyKc@martin-debian-2.paytec.ch>
References: <20220401183513.26222-1-fmdefrancesco@gmail.com> <1724388.VLH7GnMWUR@leap> <Ykg3Xfb4vjjGSyKc@martin-debian-2.paytec.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 2 aprile 2022 13:45:33 CEST Martin Kaiser wrote:
> Thus wrote Fabio M. De Francesco (fmdefrancesco@gmail.com):
> 
> > > >  	pnpi = netdev_priv(netdev);
> 
> > > >  	if (!pnpi->priv)
> > > > -		goto RETURN;
> > > > +		return;
> 
> > I cannot see how pnpi->priv might ever be NULL.
> 
> Even if pnpi->priv was NULL, we wouldn't need the check. It's ok to call
> vfree(NULL).
> 
> > After the two removals I've talked about above, the code will always call 
> > vfree(pnpi->priv) and then free_netdev(netdev).
> 
> That makes sense.
> 
> Best regards,
> Martin
> 
Hi Martin,

Thanks for reminding to me that a vfree() on a NULL pointer is a no-op.
I'm going to submit a new patch with the purpose to re-work rtw_free_netdev().

Thanks again,

Fabio



