Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259A519C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbiEDJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbiEDJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:54:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F373726565;
        Wed,  4 May 2022 02:50:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gh6so1883256ejb.0;
        Wed, 04 May 2022 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHS0dNPUTTWev9wBUevCzLBbQ9jyUkd33b6t/uAtuno=;
        b=lA+2WIrGFabicuFG51MUFddibVXtXzR/C8uSlDcOEYUuL36bqMf+KVXicmEhbp6V+Y
         hkvOSITcNA3j5kcw5A4LMehn8oMZisF8+ZZwxYaQuEtXKU1urqv0fdo4fVbs1XZBMLds
         qsmIr5bVYjd7bBmUrub1Rnq39lqQft7DMZue/rzEC8iQwormAemtm56fglCBL9YxcRvz
         vdoRGpKFZyNyg92k7Xl0AxnMaizV3ajEeWmaffQq2Y1e6oiZxGyLnZIi8m1MDu2tCw1E
         LHN6Z7xPOTXQPbVrv7Xvk15XP6DxgPGIfoEqeXNrho/9B/2ZbdMp3lcdgNgIfTU42tAb
         VoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHS0dNPUTTWev9wBUevCzLBbQ9jyUkd33b6t/uAtuno=;
        b=CEAMDbJvw/PsHxQ9yr5Om38eBLXB/su2HV3IPQlBClyrCK9EiS+LQmyTFi89R+/JuA
         aqGHlDh4zP3loMqHQJlonnGTk7qnYzrBRrdhPUTonG7UVrPsAEqLscF1eAe85s47ntrF
         WGdcIOmGPuQvEwRGxk9SH6t0iwFkKjNKMNFEv510PsgQyKClKHerqtxewik1fr5HkCGu
         Le5Ti3ENFjoCvwmq0IDwSweETZ0MSkJ34czzbZwD4IAvrIbJZzWC8veCfqslkGPwtw7A
         Y+0F5Qz9z1MAxEoZJ3jBDVZR/W/CFqAjRFbOuG2UIdEPSIc4HEmrsGpC2H7sz+piDHdZ
         SK/A==
X-Gm-Message-State: AOAM5316ol7SygTqRgYXUmdImeAjDKiKm+Q5IM7ePuRZjRZTKQm95ESE
        i+S0CDDRTfnlmNIpeUMRbg==
X-Google-Smtp-Source: ABdhPJxru1BQcCxGnN6SrEs52WDqGgNeRTUVZ4hBSFel062Nfj2Qb9bME+ohWbs3u/j4dlfjxbuAkQ==
X-Received: by 2002:a17:906:300d:b0:6ec:c1b:9780 with SMTP id 13-20020a170906300d00b006ec0c1b9780mr19367590ejz.415.1651657846403;
        Wed, 04 May 2022 02:50:46 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.36])
        by smtp.gmail.com with ESMTPSA id u21-20020aa7d0d5000000b0042617ba63aasm8931013edo.52.2022.05.04.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:50:45 -0700 (PDT)
Date:   Wed, 4 May 2022 12:50:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: fix [e_shstrndx].sh_size=0 OOB access
Message-ID: <YnJMcyhF5bv4IJAq@localhost.localdomain>
References: <YnFC93NVRqOterbV@localhost.localdomain>
 <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 01:15:04PM -0700, Luis Chamberlain wrote:
> On Tue, May 03, 2022 at 05:57:59PM +0300, Alexey Dobriyan wrote:
> > It is trivial to craft a module to trigger OOB access in this line:
> > 
> > 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
> > 
> > BUG: unable to handle page fault for address: ffffc90000aa0fff
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
> > RIP: 0010:load_module+0x19b/0x2391
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Thanks! Can you resend and Cc stable?

Stable will pick it up simply because patch does apply I assume?

> This seems like an issue present for
> a long time, can you identify the commit which introduced the issue?

I thought it was ancient code but no.
