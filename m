Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3D5AA161
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiIAVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiIAVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:13:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3E8E980
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:13:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11edd61a9edso330012fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s3YP/G49fM/Y7AAkh3BQLrT9w+DYN0rWK2mog9WKUQI=;
        b=seTbvoadCOx8zLoFZ3UlN7zO9Qd2nQyjqfN6FbJRoAPWKoBxFfK99LZK2nESbZvQm4
         E1AyX7vSDbRY3+wZWnpuhh4Jfjq4ft3MGlymzc+PvFvDxev8cNYHKShpkFo/CIQVXPcL
         3gBGs33hTZngFpD1iYGlwsZUP+r98NPI5ZSXaVwGRCkmJabnjIldQgecxdcIRROPJYFd
         K2qIn8nm0Zg17/dCyXbtcVlNCVlyGhs5BgCw1ds/xUw0qwAa9Rq7kWatfb1izk1yjSAm
         NleTPRdgUEgFyOL2qpqZtbkVkXtfWymW78YkYUHWzATBuvwWBJtX53bFYxOtHnx3az4/
         p7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s3YP/G49fM/Y7AAkh3BQLrT9w+DYN0rWK2mog9WKUQI=;
        b=VehP/BKVU45nzqzn9S6hGS/qxUCyEW5Saqc6L3cXajVMequuOpn0/4hZpaUsHMZzCr
         q4fpEZ+6ncxGhsbseGNJIxYWOhKzBgP+JbdNmLpwjxt9Ljd0h5hlhEH0PKHKAeZQicrG
         4MAQ/JD5ipzFhK2AgEAd+ry7v9aYTPTMpKcdDFhI766BJrv+kE+P5mMwFhaX8/o3yrHB
         kBnzmKIFaNs/T0lqHG5eA/vqEFsQZOOPek3CDdU4sDioFeQwTORCEVEdsbkNrVV91rbW
         SbMHCqEeKOM/c43WPQ+nnCfo/C6i36tHJanbXVhw7wog1DojnbCfoCyqLVMZ0qtsn2ny
         HjHg==
X-Gm-Message-State: ACgBeo2iFsY9kyX7GMIhh9s4BRKReiCFXoRoGBIEBMLFF86zxisA5qHS
        7a5TcGEY/b7ogf759+gmeRfXb0YweO39LTvpCQkSCQ==
X-Google-Smtp-Source: AA6agR7rI+mWvl/3lX7XXDOjn4pDkkVMOXENRZAXKurcVmgUPXFO3foZFRrFHQD7xMtM/oBbXhq4dO48ZF6cxIy9CpU=
X-Received: by 2002:a05:6870:5a5:b0:122:5662:bee6 with SMTP id
 m37-20020a05687005a500b001225662bee6mr579105oap.181.1662066811990; Thu, 01
 Sep 2022 14:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220831211810.2575536-1-jmattson@google.com> <YxDfZwKAlH6KBhoH@google.com>
In-Reply-To: <YxDfZwKAlH6KBhoH@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 1 Sep 2022 14:13:21 -0700
Message-ID: <CALMp9eQo9zYjh8xqtMp_JWOSMCd1cBuqbCo2KAPTLWaroB8MWw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cpufeatures: Add macros for Intel's new fast rep
 string features
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 1, 2022 at 9:36 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Aug 31, 2022, Jim Mattson wrote:
> > KVM_GET_SUPPORTED_CPUID should reflect these host CPUID bits. The bits
>
> Why not provide the KVM support in the same patch/series?
>
Coming up.
