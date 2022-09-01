Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847C5A99F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiIAOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiIAOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:19:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FB26F1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:19:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so16519608pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ix33RwIZe6mRd1sTXQ3Y1m/z08+SgRoDf/2gFTrYsUk=;
        b=DNW9qLZos2MITbYx3OLQABiaA1n/SChUDErdSobjcMuBwcomiqbmqDO0emxYUuRki8
         gCT1qDCnaziyrCeGeFmInKAYa40ulRyXsQFTYIi14onRl5zGYE1UDeUgv3m52s1CiTDE
         MTbd6n3FzDv/72Mei21HjjT3Lzlr9YL+TNcy8J5yB0ihH/LKMGDYVAZkxv37A/UM6fhg
         +4B+Mhr7T7zyU4Y7eYco56do1xqZXslW5U+AqKrpIg+8NUvEKomauD6p1jYsWw8fCZDZ
         zWEnKh3qtahqlTIRPflDo7IItjF2O9p7RenNUcPirQaggFWyFpnnOZap7aPBmzH0HGk+
         xPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ix33RwIZe6mRd1sTXQ3Y1m/z08+SgRoDf/2gFTrYsUk=;
        b=MuMeq+tccdWl3RyvxB3Qvc70cL+J8KQCqvRgU+RPoXQxnXlZvdtq+LGLvrC4I7TXXa
         aCpPADmYUZ24Dhx/FUbhCiuQOklfp7QM3/qiwbYtznInYNYIN9rvkbdW9PVBLJp9UNxu
         AYMbM/oSNJRPu2Evwr11xSM89TFdMf49GI1ITNwo2/R/Sc00YfQ+dBy4XiC4wOwXK5IV
         j9hKiYSZEcVmqw3GCoLwutoWpfxCVD0mIgbcli1oOZF8vie7iyb82xHAaAvYXdAL92Va
         J8RINPKCmHwdHT/6jGZUHetk6yQpQ5P9BrR3ahdEmekSsDQyLg7rICnAM2FQa//1JTzR
         7Kaw==
X-Gm-Message-State: ACgBeo07QiGLS4GoQ/EO0TYhZ1mJzAJovHm5r4VFKavUL9ww21fw4rhc
        kI1iNT2H3nT+LFLO2nsSQc0mEw==
X-Google-Smtp-Source: AA6agR65qwgY+29rBLcJbcW4bKfGWl8iGjRoKoHceWH9aAi1Z6g1zN+iH/kgmKA52ZOp1gqeVU4vWg==
X-Received: by 2002:a63:b03:0:b0:429:c549:d1f1 with SMTP id 3-20020a630b03000000b00429c549d1f1mr27145862pgl.131.1662041989360;
        Thu, 01 Sep 2022 07:19:49 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b00174abcb02d6sm9760799plx.235.2022.09.01.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:19:48 -0700 (PDT)
Date:   Thu, 1 Sep 2022 14:19:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, like.xu.linux@gmail.com,
        kan.liang@linux.intel.com, wei.w.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] perf/x86/lbr: Simplify the exposure check for the
 LBR_INFO registers
Message-ID: <YxC/gedFQh5qf5LS@google.com>
References: <20220831223438.413090-1-weijiang.yang@intel.com>
 <20220831223438.413090-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831223438.413090-2-weijiang.yang@intel.com>
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

On Wed, Aug 31, 2022, Yang Weijiang wrote:
> From: Like Xu <like.xu@linux.intel.com>
> 
> The x86_pmu.lbr_info is 0 unless explicitly initialized, so there's
> no point checking x86_pmu.intel_cap.lbr_format.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Message-Id: <20220517154100.29983-3-weijiang.yang@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

No need to carry Paolo's SOB for patches that Paolo temporarily queued.  And please
delete the "Message-Id" entries as well.
