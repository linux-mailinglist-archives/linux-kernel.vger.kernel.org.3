Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3004F8AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiDHAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiDHAiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:38:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384310660A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:36:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id x21so12455162ybd.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1HcF8x3UIKiVVn/nUxJJBAAmWRasyyi8SHqMPG/VXOo=;
        b=oaMxNPsncnAcpTqjMOuO0KwQi4OT0SDBn7pfXGEpdMPaPrLYwKpBZBUYODAZSozbUB
         sxIKaUFbuU33BA2dzhhpejRMykt1RzGUGClcE2msSrrs2Jki6k7MAWCstFYW9FRlFpSv
         1Gq2pVdVXJ4AymSvGzwloiIO/8VW8a1mq9mA78pY6rWIw7DMc2pw6FhKoiGhrOD8k1DN
         owUWeoI1ArpIpiam8YpGd6rPRmQDd2Z6rM7ta/RnQsNhVcBNNohjucbWEzl3+vxsBsP6
         qpVwRmC1W97xbVHWYTEVYQceRg0jt0Y9/gqetveqpSbGOyckPoUOcQ/gS0TFX1dGhx01
         colQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1HcF8x3UIKiVVn/nUxJJBAAmWRasyyi8SHqMPG/VXOo=;
        b=uRXBu7FYjJZDLMNtqk9k+BCMV0EDFIL+ZIlIAgu7V/+i8OUuoTS0f6g4wG34Lh+kBX
         8VzEhuQI1L1dqfpOO4f8kXqONOJN6GF/3sl24LQOcr0bqsOvnsuNLesPrmhgFXYSdTGi
         tdvZtd6eq3S3yvpblM0PxIRNVY6rtOpU/Ky3XEwN5K6Rs5O3vHCPc9SN7XhPTeT6wSIy
         LILfYUxM0Wl2BUrerupKbaDRZQA3499OXvrxINFEGO0Lrzh/7vgn7aXeVYG32+pSyAcp
         uPFV1twADoXlBso7f7o8fhcKe03k7oxRa7T7K0bs5zL7Q7B8jGYYEaOg+s3XEZ8IrfOU
         RYAg==
X-Gm-Message-State: AOAM531hVS+OxCTedbnD8Y7iuifO+sLziSo8aQeL/NR0mV+TqV43TTjr
        qJ93OMXNCFTOfrXJrYxcQfsiTJz8iaUc3DiYRrC2xQ==
X-Google-Smtp-Source: ABdhPJzWsXMCj1cr1xBJojZihq5vS7dfcZikd6HI1JCDrpJQ8DPYyVnw3ZmLS5hYc+g9AjciEhkP1I+4TC/Qu7iRa8o=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr12978643ybg.352.1649378212045; Thu, 07
 Apr 2022 17:36:52 -0700 (PDT)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Apr 2022 17:36:16 -0700
Message-ID: <CAGETcx-tH0+WoqH6s=Zw6VSaHwFcBhvaJKLJRLHGtUEs+skCvQ@mail.gmail.com>
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
To:     pmladek@suse.com
Cc:     Chunlei.wang@mediatek.com, john.ogness@linutronix.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, senozhatsky@chromium.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -75,6 +75,7 @@ struct prb_desc_ring {
>  struct printk_info *infos;
>  atomic_long_t head_id;
>  atomic_long_t tail_id;
> + atomic_long_t last_finalized_id;

I really know nothing about this code, but while looking around
kernel/printk/ I noticed kernel/printk/printk.c has these lines in
log_buf_vmcoreinfo_setup().

        VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
        VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
        VMCOREINFO_OFFSET(prb_desc_ring, descs);
        VMCOREINFO_OFFSET(prb_desc_ring, infos);
        VMCOREINFO_OFFSET(prb_desc_ring, head_id);
        VMCOREINFO_OFFSET(prb_desc_ring, tail_id);

Would this header file change also require a change to that location?
Something like

        VMCOREINFO_OFFSET(prb_desc_ring, head_id);
        VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
+        VMCOREINFO_OFFSET(prb_desc_ring, last_finalized_id);

-Saravana

> };
>
> /*
> @@ -258,6 +259,7 @@ static struct printk_ringbuffer name = { \
>  .infos = &_##name##_infos[0], \
>  .head_id = ATOMIC_INIT(DESC0_ID(descbits)), \
>  .tail_id = ATOMIC_INIT(DESC0_ID(descbits)), \
> + .last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)), \
>  }, \
>  .text_data_ring = { \
>  .size_bits = (avgtextbits) + (descbits), \
