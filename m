Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF895951E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiHPFTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiHPFSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:18:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB345C345
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:42:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w14so7471389plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=8LW1Z2eHtfRzkh/DgEsbiz4wPXvg86VGj0tcalow2gc=;
        b=aUIKmdx49jY2qpswU91D8urED0N6BFbxXQi/EbnSwbikNL/hePNE1obTW9O8LEYSIW
         IHI8Q5mAsHRrvEas1zNypoTBA+TZJlVseJQDg64SvfXMVShTvq+A/AZ0WKi8PiW1JzGH
         sZ/WWE7MoQoz/DZHFisZ2JIJ/fSkaTqeMXdZV7qxk2YcyDjlehEukw5lJTSY54hjBg0B
         81qhQsRES3XSGUVyOEZZnDrRs7weG6zPS5mm2Int4cmKUMKYCP8Rc1diBHlrJ9sFYFOG
         G+0rA+MMxjS1kZ0LCg1JBq6AUZWcb6zgZXAGmBBIdSJfKYvQQvPlf2hi3LmT5kEB00FE
         ZhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8LW1Z2eHtfRzkh/DgEsbiz4wPXvg86VGj0tcalow2gc=;
        b=X2mVhoM2Gc5+5Zb/vz/x9h8qoOiTCde35csE3kXshweXNZddBbeaGeVOUFjU+Aa/xO
         ad6CeUMx+qo2untpPvn2DuvE5zgTlZ++i/rZT4F7S3yZtuLDvLfFX1+FQu1n7aoMkEVK
         pg6FB8mVefo35rDNSqQPVOdSGbMDkeSztkBzpaLaO8rI9RP8Gld9R90z1iWJc1REDPJm
         VQmumU3jYZz+auCAlZoiXUI3enX6Pf3HYmXhkd/u2OcmEJX8655f4hcssua/2e6x8mIa
         LCz9UVNH3BiV6jfeCMIMhVCNiZJ2VBnjhGlXtEdTz7O2C/W7YRh7W5yMeaLheufg26Dx
         oIXQ==
X-Gm-Message-State: ACgBeo1FtWa7kE+eXwe4xKLdap5+oRkYkR9Xp5yQ1IzjLjGInHk/z/5q
        0f4y/PTNLntv0WR6+4b1ZPlEp0H/6ATX+A==
X-Google-Smtp-Source: AA6agR73ib93qkb4fwGAobfuvJZGyS/QKaScq6gxXlAO16qAVl0y6157lhvwxcdRKKcvrkCAnkAkNA==
X-Received: by 2002:a17:902:ce83:b0:16d:d667:d4df with SMTP id f3-20020a170902ce8300b0016dd667d4dfmr18614380plg.159.1660599751433;
        Mon, 15 Aug 2022 14:42:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b0016d231e366fsm7456080plr.59.2022.08.15.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:42:31 -0700 (PDT)
Date:   Mon, 15 Aug 2022 21:42:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Andrew Jones <andrew.jones@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com, xudong.hao@intel.com,
        regressions@lists.linux.dev
Subject: Re: [KVM]  e923b0537d: kernel-selftests.kvm.rseq_test.fail
Message-ID: <Yvq9wzXNF4ZnlCdk@google.com>
References: <Yvn60W/JpPO8URLY@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvn60W/JpPO8URLY@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022, kernel test robot wrote:
> commit: e923b0537d28e15c9d31ce8b38f810b325816903 ("KVM: selftests: Fix target thread to be migrated in rseq_test")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

...

> # selftests: kvm: rseq_test
> # ==== Test Assertion Failure ====
> #   rseq_test.c:278: i > (NR_TASK_MIGRATIONS / 2)
> #   pid=49599 tid=49599 errno=4 - Interrupted system call
> #      1	0x000000000040265d: main at rseq_test.c:278
> #      2	0x00007fe44eed07fc: ?? ??:0
> #      3	0x00000000004026d9: _start at ??:?
> #   Only performed 23174 KVM_RUNs, task stalled too much?
> # 
> not ok 56 selftests: kvm: rseq_test # exit=254

...

> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 5.19.0-rc6 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-3) 11.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=110300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23800
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23800
> CONFIG_LLD_VERSION=0

Assuming 23800 == 2.38, this is a known issue.

https://lore.kernel.org/all/20220810104114.6838-1-gshan@redhat.com
