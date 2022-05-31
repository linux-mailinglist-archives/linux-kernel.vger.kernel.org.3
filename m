Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFF538A56
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiEaENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiEaEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:13:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047F506DE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:13:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2e0a41009so15364478fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCsOS1dbQkp9Cq60ttd5zyN8EWYM+8T7qq4aCYdpQiE=;
        b=oMxFyxIRvlqxf4bqIqXWe6ZRh6p5SAHt/ikq46mzUh3RDI194LboMnWHaxhRYL2KKa
         uirm3N0D2DzKi3V6HW4HGV8QQfjv2t3Wg1fPz8ekpfMVEu/OIq1pUJjmSbLOHzVJIRQh
         uRRF1O3ksmFwvyjvhUMDNQX0uTx4K0sj/+WRbtCgYssM0yzVSvLIBawce14N/hWWtqZ2
         HdAF7LLwUv4uu1rpOL4xK/tsbCALTU3Tu/c4bw2TbLkcn5Fghteh3PfBcIzGPAQbSKk5
         6Z4d4ZnOkWUCMW26SN/wwKTIjNrt1FDh2IFm82nZ6NwJrOOyUtIcER3XnvcFSGCPAeGY
         y1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCsOS1dbQkp9Cq60ttd5zyN8EWYM+8T7qq4aCYdpQiE=;
        b=IeAu/YYKTrD3N70Rb9Hrp1ibJSUTJW9UFhF1Gp9BwQF4srsMKo0RvKlU68O8XDIRtC
         ZdbDHLeQi+rZQ4DM6ADcugioDiviOByKQ7F6eiO0WHaPEHm17apwIiwFffwofTjoUX8L
         ov9u4trkAg7PVWEBEzmztwSZEu9Qt1yMmb3ZU6/lJtS8sST7GTprE85lHRVzwL2IZAiv
         c6hkEBHfqB9JgnOxND0ecl4zUs7XAVww8J4zcAyZTYgdrcIvl/679D3KT3SsTATzzq83
         ATqc/W7v415qefQkNKssXk0gybGLAIbWkeahmm314kQODiDj0IpeWKT8WP7et2PW8etO
         Rh9Q==
X-Gm-Message-State: AOAM532HGSGgA0Ffj7XyTXeebqcIRj9j7nmhG1LJZFUwCwUWui0scb4G
        /ko/mX1v6TINL6ZuofzGw5b+fMtdhb8=
X-Google-Smtp-Source: ABdhPJz04g/QdGAMK8vZYKCUrZqBSWnZO1WV9vgt2o/5pkX/7p8h8RZW6Pe0ul66az9Vgz1So3o2xA==
X-Received: by 2002:a05:6870:d392:b0:e2:aa54:9601 with SMTP id k18-20020a056870d39200b000e2aa549601mr12699399oag.184.1653970382386;
        Mon, 30 May 2022 21:13:02 -0700 (PDT)
Received: from geday ([2804:7f2:8006:952e:2515:89b0:77d8:3ae])
        by smtp.gmail.com with ESMTPSA id bg19-20020a056820081300b0040e6e53f6bfsm5775455oob.15.2022.05.30.21.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 21:13:01 -0700 (PDT)
Date:   Tue, 31 May 2022 01:13:03 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpWVz51hyMo+w4a4@geday>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
 <YpMDmZZ7IpEhjywp@slm.duckdns.org>
 <YpMKY88/2tTK319E@geday>
 <YpMPPyIZVlBwUrNe@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpMPPyIZVlBwUrNe@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 08:14:23PM -1000, Tejun Heo wrote:
> Yeah, you're wrong.

Hi Tejun,

you were completely right about me being wrong. It's a real shame to me
and I am only asking for an apology in case there were any doubts.

With my "patch" I was unable to cancel service on the GPU ("sending
SIGINT to MPV because I like to Ctrl+C") at the same time as running
ROCm inference on the AMD Renoir APU with amdkfd of amdgpu.

My machine froze beyond expectation of recovery, I would like to see
what e.g. netconsole would report but it's irrelevant, it would case a
major regression in the kernel tree if this was ever introduced.

Sorry for the misunderstanding, I guess it's the burden of maintaning,
too. My deepest apologies.

I'll follow your advice and try to be more careful and detailed without
mixing what I know and what I don't next time.

Many thanks,
Geraldo Nascimento
