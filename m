Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E198E501BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiDNTYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiDNTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:24:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73BAC072
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:21:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so5493545plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqcDskH7+pjeGH7+37qMSCHWZnRKgjNETpAFgYRNMIs=;
        b=ralvO1dTp/gCrVUeK4H59pMwEVAPwElTaOS0owWd3cnlJgqrfycvpyLMCu9ZySvvP4
         1PPPN20eN/WeHw2jUl8UVzYLCE1lEjVGlrh3pz3fD3AcMLC2Tdfr06CDPOu9p+C9reE/
         Wyi+idya0F+Oz+ascwRtDVxsF34USIwfFz4PLOYkOmHDee9GmMTLBU0CB54hCpC8QPVo
         GvvcU8PJkIke4tFlEyKV+40K9HdHkZZJtM2KlVcG9ZHLlN9QC5tHpR6poipafuFyeNkd
         viRcTpLBUZfOe1oGqMnyadap9nXgXJnRr0D/YN861mNyOP6NyHQTjNZNpkNanjk0r3RL
         PUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqcDskH7+pjeGH7+37qMSCHWZnRKgjNETpAFgYRNMIs=;
        b=qd+iIpaXcZiuUJ03DH++MT+9q7PXeGB+WDTU1PoX5awzq+0nRk7wKe29645yfxxID+
         4C7761jxPdBnyezSdQRuNCPPyS79AB/AAqY1sAuI10ExpZxZMOsyh+kXiBRPgYf2/nUo
         Hax+ToIkUB8152ErjALNKMt+/h/RgSi6/JiZcrSL2DHvATgg3Rp+jH/2iyFheiAVFOrG
         18GSrZtFIlUw0hWZnHZzFSpwNMjG6tBiXDcnCAAb1fZ8KZVWEwzrtY2cJ7w+8Wtx98So
         bEkTrWHZw7ezvvxqQyYIeBoK0bCf2LHT6sOzmr/o0P26KV7lvjxhZ7JiLaElq3f5/79g
         pFpQ==
X-Gm-Message-State: AOAM531eOSJhpDev3wDHLYc/JliSOSv7XCD4UF8bQ6iKv7IYPZ/ANFDL
        7Pqf9s9q/8PFFtfo89E6hevQjA==
X-Google-Smtp-Source: ABdhPJzxBPselW3Q3EB5PKFLA8hFRyq0lndHWgT+eEnFy1eNdO9RQL1DGbwuOYfNuWhRdY1rbTqVDQ==
X-Received: by 2002:a17:90a:a4e:b0:1cb:58a9:af2a with SMTP id o72-20020a17090a0a4e00b001cb58a9af2amr97699pjo.101.1649964108037;
        Thu, 14 Apr 2022 12:21:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm676940pfm.17.2022.04.14.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:21:47 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:21:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, mlevitsk@redhat.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
Subject: Re: [PATCH 1/2] KVM: SVM: Introduce avic_kick_target_vcpus_fast()
Message-ID: <Ylh0SE5obsyHghCM@google.com>
References: <20220414051151.77710-1-suravee.suthikulpanit@amd.com>
 <20220414051151.77710-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414051151.77710-2-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A drive-by comment on the shortlog, something like

  KVM: SVM: Use target APIC ID to complete AVIC IRQs when possible

is much more helpful, e.g. I had to read the entire changelog and most of the
code to find out what "fast" meant.
