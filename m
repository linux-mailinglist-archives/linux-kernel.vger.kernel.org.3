Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED2505B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiDRPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDRPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:37:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461F43AC8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:58:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 203so282777pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2IKsl0r2BSuorLp4M44A7ST1Ma8D5KyyvedUZ4XIDP4=;
        b=nAvXz/5vORInmD8gjILRyeA01D2ped7B3MaCvkrKcAM2HslwTxLQlwRowLWTKLSaDA
         foLe27T9bpBKHGQ90b7xoo9wALRH4OLNJMhWw2c2L/LMLntQfooddnUGazfH9mvm6faz
         d0D/xaLx84ifR7J7O2o+mtjqkEjKMSPCYyTBFbS0VcyXFZoeoXuMI3cPdFE5kZLPf8JB
         uaTe1alkz90T3k/my0iyiMxF+EH7p5qITa+jk8jmGriLBYKokuyYFyiF8539Hr9Nb0NZ
         /ICKzrzOFUtphPbYOKrIW4+Ao4ijZzIf81SqcN2ZNjt3MpIJ5ltPK1LlMzhpZd6yk6FI
         zXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IKsl0r2BSuorLp4M44A7ST1Ma8D5KyyvedUZ4XIDP4=;
        b=sAuLk406US7p4AKZJFJbErWL+T0jm9/wrfXd0vOyJMEJ4SRY/IUwk/bXjNueekOJ0y
         D7igrt6W3Q9fiUNGTsDcNU/Xy9CR/CfnMo0N2yi++SLFpq/VGidmebZcQIyqduUaWo0D
         +1Vyt2ids+jKHFbr14hV1MN24bBmrIB/GhEKrE3MoeL9fcN2b6XQknJgMn8XIgoSHry3
         TXnchISlUhTMTLYXvL5iYeKY37Hg9VI5THoed+O8nKqInp+L27CURZ2cfInUzCzADlva
         B8nN+7AE4sxVxX3uJ/q8+9X47DQzc6+b8JedFylopdwr6yOP3nenxg2ALKaNsRyo/aIJ
         k3aQ==
X-Gm-Message-State: AOAM533DeJGl05v6ZOdcmd0pF+QFKkJAHGsAhZPirfk6u1/b8Zl41li+
        9/rcxneN8UzOE4RJSuYvLVl8Hg==
X-Google-Smtp-Source: ABdhPJyqS6rtXiFf9c/R+wkdcJPFqHiNgaYyNUnrEcjUMn332HCtNJDa8mRmnb5EpDgz9gniv+rx8w==
X-Received: by 2002:a05:6a00:22cd:b0:50a:69c9:1806 with SMTP id f13-20020a056a0022cd00b0050a69c91806mr7445509pfj.51.1650293886623;
        Mon, 18 Apr 2022 07:58:06 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id e1-20020a056a00162100b0050a40f75a82sm11771560pfc.113.2022.04.18.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:58:06 -0700 (PDT)
Date:   Mon, 18 Apr 2022 22:57:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 1/5] tools: arm64: Import cputype.h
Message-ID: <20220418145751.GC166256@leoy-ThinkPad-X240s>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-2-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408195344.32764-2-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:53:40PM +0000, Ali Saidi wrote:
> Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> for arm64 to make use of all the core-type definitions in perf.
> 
> Replace sysreg.h with the version already imported into tools/.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>

Please drop this patch in next spin, it has been merged in the
mainline kernel.

Thanks,
Leo
