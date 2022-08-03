Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084EC5892C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiHCT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiHCT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:28:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996A95D0C5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:27:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4283446pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2y77GU73GtesLx1ZtH3/2t6LiwaKzcbAcF+3XUlOrIE=;
        b=ZH+4bGmCfY18KAUOE0TU56IB4CqJVxXkcOQi9Q2oQu2TJFaVC+lQvxvnm4cJXO/lJ/
         JDo/qLDm3aRMqyMt9rbB+2GbNVSq/8Loujui7cCWZpE2Z3E+lndxAX59/EBkLhaRc4K7
         ZSrXHpVnRGTyL4Y2Pcmfe6dFShdWLnJ4DPmcVvByLJ74NfEAbTwo7svQ2RhoXBEQDPb7
         u79e712PkBSY3GKz4d49RA94T1BdHLHT3wL4oUdP8eRjF6kX7lth2vy5H05adtjuqe50
         5N9kVsCOfPrO11UzsQFPcUASUE7l3nmd2k5B5CGKF6GsHS206mQRtapxewsFXo2agSgQ
         yzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2y77GU73GtesLx1ZtH3/2t6LiwaKzcbAcF+3XUlOrIE=;
        b=KtJ97UXBaW6EyTVYsDRjIJ6mwJRJXx01uCLbsDXXlnvp2NCUuRuIiB3UevgulJ50nD
         iAtM6rjSniZZcgt3P/l6U7Waseqlrtt/FRxK4O5SFSCuwqp+P1dFaYYR4YFj+pQdUj4I
         PI2tlimtGhQE6IK2tW4gK6oP8Hu28K7MEm6ri949+3AORofVmajaCH411Za1kikHdJYC
         D42nL9sNxHw2qFHzwz8CpHsnLriwXDdIXq6ENHQNE51VFOj6JvmWxKTgaiAqdWhvl9Bz
         JnLx7WXwqLMnBMPhpbpVOh1obuc7kRRL37JtXc1GHyV8TGlHVs9eRh176aMq29oP7anL
         dwuQ==
X-Gm-Message-State: ACgBeo28pQcM53ivuhb749FPa/Osl4beNSrG1B3VqYcICFOLHR06qjwY
        Q26XozLz6SCrXh/xdRueI68t5mz/5Y2iFw==
X-Google-Smtp-Source: AA6agR4i/AQ75/75Xk1rPA/tsU66D3+h7/pEvk8iU6Wt5s+DCUbse2toF9wf4QBfO2T6t+oN1ruWsg==
X-Received: by 2002:a17:902:ec90:b0:16e:d8d8:c2db with SMTP id x16-20020a170902ec9000b0016ed8d8c2dbmr19613146plg.69.1659554866328;
        Wed, 03 Aug 2022 12:27:46 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709026a8400b0016be834d54asm2298951plk.306.2022.08.03.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 12:27:45 -0700 (PDT)
Date:   Wed, 3 Aug 2022 19:27:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2 1/2] KVM: nested/x86: update trace_kvm_nested_vmrun()
 to suppot VMX
Message-ID: <YurMLf3MDAK0RiZc@google.com>
References: <20220718171333.1321831-1-mizhang@google.com>
 <20220718171333.1321831-2-mizhang@google.com>
 <YuqnP318U1Cwd6qX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqnP318U1Cwd6qX@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost forgot, s/suppot/support in the shortlog.
