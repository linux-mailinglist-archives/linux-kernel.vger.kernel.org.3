Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445A4C7840
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiB1So4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbiB1Soa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:44:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07FB63
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:42:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso12097219pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wxrH6KzaeaBEDEh4qmMyftFti+mIlwQaNwQ6NwWTZ4A=;
        b=TxXrbMTMd6jCS9SU+C6biZ3U82+A0ZzyMEQOKLZ4OAIXCgnxixdGhQxyciBbu4t+hZ
         Ez6FMN5Ta1l6/NMHEH2rEzUwovfp8JOTUJy8RjVZwAvxuf778JssaPZIabWihQGTaXWu
         h732bzFtcD4VN1j2oHwHV++zXc8cTUAfxe//J/qM05iVC/HGqj7q7eRpei7zE0LF8g5E
         TQMK7eUjFj6jyrLZafIuG48eFbWPjtxnG1V/uwjyRE2Qypo4tXywZJ+iTYTFSYAViA9N
         tdFnxLo031V03cKhptQIqEB43gWUZtGEUmRuW1O27E/ZygFeoERI2aF2Ny19AJJ8+WO9
         G18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wxrH6KzaeaBEDEh4qmMyftFti+mIlwQaNwQ6NwWTZ4A=;
        b=dHRLvaHCa5II7xFGvl47TWts1DBXyfJxvDvHX3jeDZYzSkjviKGqDmVNWmIMDO5pYM
         SisFKzD9jMQBCBzi/4U+Azzpd4VxoQbP9UTO4ETNH+cl36bsv19yJ5d6xLTbRzGIcpCI
         oC5yJC/6X+9rQkb67xbAOjF2B/PBxaI4MY/4Wp8mahfJfQRA3IR8T5yHZYDuaIJBfYHE
         oGwOGrRKTT0OIS24UC4JW4eJdrJNB7ztZoVrNiHOuwoNLMXdENd7agkFQOoxbcDNRwKj
         FoqgljRz0YJoRDPAUPpybBpVbyzLUx2RPMKZFbmlnmJ6yRTkNeoXzsQ7Q1TcVZqgReG+
         +uOw==
X-Gm-Message-State: AOAM531AXPrwuUe51b2VDNPQfozbnq4Pns3nENKIjTJaXJ4wnEj5qKuW
        RQzhLk66nDPiZOt+lSz6o1k=
X-Google-Smtp-Source: ABdhPJyJeDth5vK1D0r18B+GG0r8Z7C8dPa9EQUR0yxfkpM8i6X1Zbnz02oJIxGKvLWmzj5vj477bg==
X-Received: by 2002:a17:90a:ea83:b0:1bc:2cb6:78e0 with SMTP id h3-20020a17090aea8300b001bc2cb678e0mr18273672pjz.20.1646073755517;
        Mon, 28 Feb 2022 10:42:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id my6-20020a17090b4c8600b001bc2cb011dasm94592pjb.4.2022.02.28.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:42:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Feb 2022 08:42:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] workqueue: Warn flushing of kernel-global workqueues
Message-ID: <Yh0XmUtuuyaO9j8j@slm.duckdns.org>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
 <YhUdjip4VSWe4zDO@slm.duckdns.org>
 <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
 <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
 <9a883d72-ea7d-1936-93e6-5c2a290509d4@I-love.SAKURA.ne.jp>
 <Yha1LeX4OK3cLCV5@slm.duckdns.org>
 <4165db50-1365-549a-eb77-6122c78d4814@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4165db50-1365-549a-eb77-6122c78d4814@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:03:47PM +0900, Tetsuo Handa wrote:
> Then, what about this?
> If this looks OK, I'll test this patch using linux-next via my tree.

Yeah, looks good to me. Can you boot test and fix the obvious ones before
the pushing it to linux-next? It probably would be best if this is kept in a
separate branch together with all the fix-up patches. Once things settle
enough, we should be able to route the patches through the wq tree to Linus.

Thank you so much for doing this.

-- 
tejun
