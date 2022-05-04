Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65D519697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiEDEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiEDEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:37:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857329838
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:33:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso255790pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=u5bwgbU/u2THMaKek6u+VZ0brdu2CgLbT0CNVkuMglU=;
        b=aQ5a89neQDtDThSNwgDwVeYxwtbAwk+D2D9fbCE2A6JCMiQBw06O1zBTvgwcDA13kL
         7Eh6mYHWlHyr6FVfEd6PPHW4vEo/snVIEoehPXR2Ph3wo7JjHTPR7ect1L+k2INUsJoJ
         GGl8cI1RIzLrEAPCafv8vEdsup+LwbsH52/RS1Jty4XCJJic/f6OUayFG/6IypQKCHKr
         WLnCzaLYKeBqVbsOYXHuxfuFUY18vrXwfqyAYoQBtFepG9HFAm/FmRCRSANu4NY9ttj4
         NuAsAckyN0kErj+GbSUloJVIAf+ghznEk3/7zkcEB7KIWwQCaZqWfQ2Ec1bmucrsFfm5
         DRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=u5bwgbU/u2THMaKek6u+VZ0brdu2CgLbT0CNVkuMglU=;
        b=AigblTX3hBGTrxOh3T9QWUZaZczMKApJespXDPyiPA1Osg/t4RocTDTKZG/XybjCiU
         4ogGk/qjeoaYIyuuneT3pw2kc1QfnTC0jVl46ab4q/uwODCsWR5eRlfdkj3lWv6RJ3s0
         k4Zcv2Jxdw6N4r4p6HjNi5WYBDWq97WnTFjcBP+/g/qF2ZiKn3ZD6Qlyy5E3T5jmA7Hm
         2v8trEckGEO5HVlfWXAUmV/hNwJNFK7R5sF9Fk8sNJaifkxVU/kvGE9o/8OjkeS9AcDn
         m2l7qpdlKORQ4CDTX7pBcrPlpyLWB+F1IQchRKwuWVppVf4k9aVzjWVvDoQPMDNpPqA8
         yMvg==
X-Gm-Message-State: AOAM530Ka8xNryfWdog0dTDlanoP8dLVSefcpo3vr4ma7w6Chndf4oMt
        0heCar9GFslyb3z+Xha//f+ofO2j7734bA==
X-Google-Smtp-Source: ABdhPJzpXaYyTBzav+axwFSE/+WEEVIlLxsKf5UZPsGDt1MSWopZrgJrpB23kQpGpCkwwzjkWu+FSA==
X-Received: by 2002:a17:902:cec3:b0:15d:124f:9829 with SMTP id d3-20020a170902cec300b0015d124f9829mr20018660plg.1.1651638805622;
        Tue, 03 May 2022 21:33:25 -0700 (PDT)
Received: from [2620:15c:29:204:81bf:3703:f79b:1d5] ([2620:15c:29:204:81bf:3703:f79b:1d5])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902e41300b0015ea95948ebsm4064079ple.134.2022.05.03.21.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 21:33:25 -0700 (PDT)
Date:   Tue, 3 May 2022 21:33:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/base/node: cleanup register_node()
In-Reply-To: <20220416053902.68517-2-dave@stgolabs.net>
Message-ID: <b1b8c212-30c2-a638-d229-75969cd8c18@google.com>
References: <20220416053902.68517-1-dave@stgolabs.net> <20220416053902.68517-2-dave@stgolabs.net>
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

On Fri, 15 Apr 2022, Davidlohr Bueso wrote:

> Trivially get rid of some unnecessary indentation.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Acked-by: David Rientjes <rientjes@google.com>
