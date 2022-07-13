Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5A572A62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiGMAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGMAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:49:58 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FEBD6B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:49:58 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bf634bc50so12380426fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/EtJDXI2fz8pm2wa/kg91uhQuEMJnLZy4xD2Ju9pYIk=;
        b=s39mIbAI2ALNtOBYHbU/VkwT73TA80TaeGinWpvDDpg5H3a9LBgudo/v3+1ifSaEm5
         shcfXZjErGnl/uDUS1oZNGTfzdalN26eaFp4zzyZZYAzlWpxt5La07ynkHXjaA0FIKtU
         H9+YJ9qCCC93KqGRcZTJciCP/ummIwsp4+CLskjVdNJzcB+rzuKlMsxZTGxjYPGBXxMZ
         TZzuslVwc00c+XxHr4mwN6e61+Vxc9OgDcS09N29D0RNxNL6DtXsVwDaMdpb20k2DluW
         p5HMpYB1Xc1Wi1gugZR3rhE/upgrMpEL1SWcHh2JU7mdnVBVKPHlQFWFOuxQoYWy4aAg
         QcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/EtJDXI2fz8pm2wa/kg91uhQuEMJnLZy4xD2Ju9pYIk=;
        b=ZlHCLZatMQB8vNAPZa+dAAnkmzauuewqWO+QBr/wezblGPd4VzlKPxSaDamU9OZZEJ
         zlBGgX+N76aIKVHYMP3ggtbd+4vgETnKHsU8JmRMrg0s1bsPDD6fOajJRa3NS7sE7ADt
         L1ulzZJVb+ySp6SWnKNQ6m0Bj0ilg4g2vEqqUghwBL6/PeI0OlChVQvWqjykxl12P3vZ
         edzFb7ydA2m9jmoIMzBo2FWCDMTo5lwPbJ6jIpFsdnmKW9VYcn4L5hw3M4FLep2Kld6V
         nWzLXEdJRfJmxxqmZx+9QUMt/JuOznh5cir/VJZ9SyR2VBpY1C7+1s9hB5GWXsmRVF0y
         1jQw==
X-Gm-Message-State: AJIora/khVQwSu6ofuulzx/wTNNzPQQiw7OVMKwVf3p4yXlc2ynEUW5m
        qFrFPWncA0WG1beHuln5v7rYJw==
X-Google-Smtp-Source: AGRyM1t0fpQLal72HAql1XzV9CLiMdeHHv4podegGh1GBikvn7WR33caIu3r4SfrlgquDp+WfaiknA==
X-Received: by 2002:a05:6870:a999:b0:10c:9df7:28ad with SMTP id ep25-20020a056870a99900b0010c9df728admr466405oab.119.1657673396720;
        Tue, 12 Jul 2022 17:49:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l84-20020acabb57000000b003264a325ecdsm4789880oif.5.2022.07.12.17.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 17:49:56 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:49:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Nadav Amit <namit@vmware.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
In-Reply-To: <3DC1239B-FBE4-4EE0-B0D1-641B64697712@vmware.com>
Message-ID: <b6bcd4c5-2311-451a-4792-6c2bc450b6@google.com>
References: <20220710232837.3618-1-namit@vmware.com> <7672923F-D439-4867-9418-B1F44EE5CC44@vmware.com> <3DC1239B-FBE4-4EE0-B0D1-641B64697712@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 13 Jul 2022, Nadav Amit wrote:
> On Jul 11, 2022, at 10:39 AM, Nadav Amit <namit@vmware.com> wrote:
> > On Jul 10, 2022, at 4:28 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> >> possible") introduced an optimization of skipping the flush if the TLB
> >> generation that is flushed (as provided in flush_tlb_info) was already
> >> flushed.
> > 
> > Dave,
> > 
> > Can you please review this patch today?
> > 
> > I feel bad (for a good reason) for breaking swap/migration.
> > 
> > Thanks,
> > Nadav
> 
> Ping?
> 
> As you know, this really must go into 5.19 or otherwise aa44284960d5
> reverted.

No, aa44284960d5 is not in 5.19-rc: it's in linux-next heading for 5.20.

Hugh
