Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2750188A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbiDNQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiDNQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E548B1042A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649951407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8D7+XOXU9/ThUKgFTw5tvJGCfDTFVw/+YuhuBqPpcA4=;
        b=YqX9av/ALWv/2mnstwo44xOqyunZkJ063obFMbRc5ndNozWD9HUK/7vkhS4a2PnZv8LSWa
        xcCV6OpBJ4LCb5nmzVJ2/CUTbcy0/v7fO8eVjGY3KgEP9+E/DpkD2buaoVhsjxnP4BPELU
        kUann/lTNuJ+Q1YK0aFZiY1nA94j8HI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-1wwDwwIdOseBfzROo0BcqA-1; Thu, 14 Apr 2022 11:49:58 -0400
X-MC-Unique: 1wwDwwIdOseBfzROo0BcqA-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so3505507qkn.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8D7+XOXU9/ThUKgFTw5tvJGCfDTFVw/+YuhuBqPpcA4=;
        b=WD0gSB3JntYyQYTA0vo5U901rAf4S72S0ZeT/uaaO9jbLquEs/P5x3bPU+k8BNBBHu
         WTX65kUK4/qAiJc+Tp1wG76AjZDu0mbvJELoVSYZywmRKDYE9QuG0pWjOt/uBp2TByOY
         ku96/pLsPThK8X5oDWorZn1W8fQi3MVm6FNpPn+Mlay+GiQMWTcXagxHfZGpf/j4FKIH
         C3H9orVBJs2jp3MhPZA3Em9PJhx4KI20hpkdcTTN+Ks/vjxm4h0LQQKjaKrttCzjm9YU
         rWrhEY0VKXk4CQTOiVjh+QAifrQLi3inT6yddVAUpDzRco/sWAHtiL0bXZB8Ehn7RfIl
         Lm7g==
X-Gm-Message-State: AOAM530x+3cPoCJlR8dAWGdpEdb/oYsWa/Ae3GGXVUIt4SoibcBGDXRa
        86KYOd7e8eM3NnqQYRsjLj0InBJ0PE0M3QdDT/VvCH9ZKKVMj37YPQNpgypRKHyaeHGunhonkhL
        +EMkgeeYXqQgGjxANetFi2f0o
X-Received: by 2002:ac8:5994:0:b0:2e0:5d77:4b5c with SMTP id e20-20020ac85994000000b002e05d774b5cmr2267052qte.289.1649951398201;
        Thu, 14 Apr 2022 08:49:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyurAOacsp1J5ypPcymXOPFueuel96WgSthlPnqzRpQHW2dly7609r5byiGD3Y+Jx818HiHpQ==
X-Received: by 2002:ac8:5994:0:b0:2e0:5d77:4b5c with SMTP id e20-20020ac85994000000b002e05d774b5cmr2267030qte.289.1649951397914;
        Thu, 14 Apr 2022 08:49:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id u12-20020ac858cc000000b002ef01d55d2asm1429491qta.78.2022.04.14.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:49:57 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:49:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 14/18] objtool: Add toolchain hacks cmdline option
Message-ID: <20220414154954.tjv5peczw3tadd27@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <e04ec8f01fcb537675d6bd94ef65103a0a749318.1649891421.git.jpoimboe@redhat.com>
 <YlfWynPt6MGR5BZP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlfWynPt6MGR5BZP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:09:46AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 04:19:49PM -0700, Josh Poimboeuf wrote:
> > Objtool secretly does a few awful hacks to overcome toolchain
> > limitations.  Make those hacks explicit (and optional for other arches)
> > by associating them with a new '--hacks' cmdline option and
> > corresponding CONFIG_HAVE_TOOLCHAIN_HACKS.
> 
> Should we either clarify the specific hacks done, or split this in two
> options?
> 
>   --hack-jump_label
>   --hack-noinstr

Yeah, maybe we should split them out somehow.

-- 
Josh

