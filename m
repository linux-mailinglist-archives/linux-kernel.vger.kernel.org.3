Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6724F8CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiDHBVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiDHBVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:21:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E9013F75
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:19:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so14343209ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZBbnVt+YQv3guhlNFNXJxYGqdHwC1mgzxEzBpvoB+SY=;
        b=w0q8eVRm7h8rkmWA6aK++gCu1l3MsYOxmQ4NRzxqJmQPLXXIlRpBBIDfMzmDHECr7t
         TtW7WfmaPG3TgJXIbeOvoAEpjAFJfTf6e8jkEM8/qC4/WqEzi5oVjtegKjbhJjdwaqfv
         MQkSGt/u4A3k8V1cQDTccN7ypBxGvfg1BimSUF69kO0VkckMQJ2M37o6hp56SSyC8jmD
         ublaU+qy3+GSGXDg6f9rWwoI4T46vRUMl5F46DQYG8RajzVrYxiQJsnil81wzJXoRYJh
         K+w0IVmThRPv22Egt4dhG8A8BhD5shYjWWXo3tbE7zDIykX+0j47Ah+yAMNIerVOUfI/
         3l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZBbnVt+YQv3guhlNFNXJxYGqdHwC1mgzxEzBpvoB+SY=;
        b=PoA+9oxm0gu4QaVJlYB4UpCABHpI+RbH7xmUlTgqN2//8bjDc9JgrxfujgpQ+tle6G
         UcJ67o6AyHRWkiJHmFSg+v+16NkQlUCs7uMa3u9MhtiGcY3qFZDSKwaHdMlUD0GJjiEW
         Js0cVZGaHaNzPbwGtxT0Wm+YGId26LCOgR37OFkp+16hGVailWA/1IR/dF0gVG/4fwI9
         ZHgPOcssWMhvEsZbPCGnZ1kxffRcxFkcPDGiQZQlMrIpOPvfl5fbSfxMmJJhKtARhW+e
         POyFk7CrsgPv4T95k/2+1ijkFLQh3dtsWc4bWqqwti4/m2K1Q/GDmYEKBISf9Qv8xGPt
         VG1Q==
X-Gm-Message-State: AOAM532vxNqV7o8fFwVMT/3fh5XRThf9vhiMONtsuvdaGDTyhBrZ/1if
        yQIjtP6E5Wb03kK4+uZmp3K13A==
X-Google-Smtp-Source: ABdhPJwjkYqFIWmuU4xWDx/TspNGWQHzwEtaxjVLRLgAWrEaj1cS5hqzQdLBd4FyyYZWUiMFo0jjAA==
X-Received: by 2002:a17:907:c21:b0:6e6:f1f3:ba77 with SMTP id ga33-20020a1709070c2100b006e6f1f3ba77mr16565078ejc.686.1649380740204;
        Thu, 07 Apr 2022 18:19:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm9807040eds.21.2022.04.07.18.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:18:59 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:18:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, Nick.Forrington@arm.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220408011852.GB973239@leoy-ThinkPad-X240s>
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
 <20220329143214.12707-1-alisaidi@amazon.com>
 <4710b4b2-5dcd-00a4-3976-1bd5340f401d@arm.com>
 <20220331124425.GB1704284@leoy-ThinkPad-X240s>
 <da902ef2-df87-ed71-275b-f7b41d1afc9a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da902ef2-df87-ed71-275b-f7b41d1afc9a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:24:35PM +0100, German Gomez wrote:
> Hi,
> 
> On 31/03/2022 13:44, Leo Yan wrote:
> > [...]
> >>> I'd like to do this in a separate patch, but I have one other proposal. The
> >>> Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
> >>> it's also in the L2. Given that the Graviton systems and afaik the Ampere
> >>> systems don't have any cache between the L2 and the SLC, thus anything from
> >>> PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
> >>> should just set L2 for these cases? German, are you good with this for now? 
> >> Sorry for the delay. I'd like to also check this with someone. I'll try
> >> to get back asap. In the meantime, if this approach is also OK with Leo,
> >> I think it would be fine by me.
> 
> Sorry for the delay. Yeah setting it to L2 indeed looks reasonable for
> now. Somebody brought up the case of running SPE in a heterogeneous 
> system, but also we think might be beyond the scope of this change.
> 
> One very minor nit though. Would you be ok with renaming LCL to LOCAL 
> and CLSTR to CLUSTER? I sometimes mistead the former as "LLC".

Ali's suggestion is to use the format: highest_cache_level | MEM_SNOOP_PEER.

Simply to say, the highest cache level is where we snoop the cache
data with the highest cache level.  And we use an extra snoop op
MEM_SNOOP_PEER as the flag to indicate a peer snooping from the local
cluster or peer cluster.

Please review the more detailed discussion in another email.

> > Thanks for the checking internally.  Let me just bring up my another
> > thinking (sorry that my suggestion is float): another choice is we set
> > ANY_CACHE as cache level if we are not certain the cache level, and
> > extend snoop field to indicate the snooping logics, like:
> >
> >   PERF_MEM_SNOOP_PEER_CORE
> >   PERF_MEM_SNOOP_LCL_CLSTR
> >   PERF_MEM_SNOOP_PEER_CLSTR
> >
> > Seems to me, we doing this is not only for cache level, it's more
> > important for users to know the variant cost for involving different
> > snooping logics.
> >
> I see there's been some more messages I need to catch up with. Is the 
> intention to extend the PERF_MEM_* flags for this cset, or will it be
> left for a later change?

The plan is to extend the PERF_MEM_* flags in this patch set.

> In any case, I'd be keen to take another look at it and try to bring
> some more eyes into this.

Sure.  Please check at your side and thanks for confirmation.

Thanks,
Leo
