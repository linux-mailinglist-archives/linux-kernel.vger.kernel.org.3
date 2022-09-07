Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4E5B088A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIGP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIGP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:28:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25061DAE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:28:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id iw17so8288292plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=XYCZQP1I7mQTgZ4Sp3CF6tpzcItR+JWciM5225Cv7IE=;
        b=C6J0LjImlh5U/JiP0IMEgrmja/qk/iwrGTNfgoPYTYa2qCOfQEeTlPu30ue1SnoHFL
         HmaXaEv24KAj8BcS9TbtdWOhvduBcT7w6Gz1UzHJI/pdFl3Zi6TpO72lb/azpjD5TqO/
         d2Ha0cOAENTHNRmBiujw8hXUgpVyYUIO32DL0NaxCOYIWB8Mt9P/Hjnw1dZGAGnnCbYQ
         pUv9f33y4G3M+fAT+Sud87PCgUatszB2L8jStRzplGGAHjDw7UNCWtKOkSIwSrjn3PFh
         53UOrKs/HUL8lkTzQ2T5QTJx6acfaN1RITDt+FR9UmfaR6CU1P/LUj/MZonQl8JrUt3c
         ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XYCZQP1I7mQTgZ4Sp3CF6tpzcItR+JWciM5225Cv7IE=;
        b=rVCBiuF+9uBmAKE1M2lnd8jVVf2/oBpP2BTcOvy5DOzU8YyEHvIGJPlvAB/rhc5i09
         lDyRaCHD6QXeOLQkVrUg3YdRpSwrcsEgvgOnyKXZvSXXKKL25i4+3tLiI2Fkgjdf4e/W
         CRvevQ24iqiV8hnspRrlYh/XCFmpsXA2p52GZLmdinYuscoks8JPVXuqHJ6A9opEHHAf
         7AD8G1XUMHy6Rf4Jsu5nFs9nPG6qMmlOr+3yV8k0vukjlhszusSaoQ80Qwh4fBqPsXo+
         AcQ73vlyf7ffMUaZViT6G5BBg8BS5Jd1oLP//TA49aVqMkAsNA3+zNm6TMQnBEC/H4HA
         TchA==
X-Gm-Message-State: ACgBeo3Mhddr4alx45vEAyLV3Fvrp692JeQgaS3dEPgIai/8E67xwFLu
        gMddQKyzSRaudXimZuAu69w=
X-Google-Smtp-Source: AA6agR7K4Ybq1M0KAYFfWiizWg429tcJCjZSRXbytJa4v3ff4Fp6FN/Mmsv0Pc4rTu486Yon8CXlRg==
X-Received: by 2002:a17:902:ce01:b0:172:59a6:fb3d with SMTP id k1-20020a170902ce0100b0017259a6fb3dmr4323415plg.119.1662564516532;
        Wed, 07 Sep 2022 08:28:36 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b002004380686bsm7556666pjh.46.2022.09.07.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:28:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Sep 2022 05:28:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared
 here (not in a function)
Message-ID: <Yxi4os4PUWSARTS/@slm.duckdns.org>
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
> 2. This patchset depends on Tejun's commit e2691f6b44ed ("cgroup: Implement cgroup_file_show()") in linux-next
> 
>    Maybe peterz-queue should include that first? I don't know what's the normal way to handle.

FYI, this patch is in the Greg's driver-core/driver-core-next branch. If
it'd be better to route these through the cgroup tree, let me know.

Thanks.

-- 
tejun
