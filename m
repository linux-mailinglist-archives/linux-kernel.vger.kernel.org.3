Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1250D184
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiDXLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiDXLqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:46:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF6D117D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:43:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so2156868edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vR6QyTXKzjneeimQgI3lYac2uhU+48R8rf60k+wC+NM=;
        b=K+eVy8LHU3Vs4eoXT0+qrRxAlQ6jVP2PJ/1UCE45qSIvmR9J0w19LAWrPbrfpkKaP0
         a+mfTOLAdPdmq8mtU1R407jZrmLBptYOTWYKm4bBBYVSCtMn7OkfZIC2UAev6uqZ/UZB
         H7jus/W4yKHDqFintBj9nBAgEPyEzumxjlQ60xsqq+ZlAy6LQUA4sqBIHkaNsdvJDmx3
         vq0hGl6iG3XztLrb9msBBk6+uHXoYQozfpjFsck/0mSWryAPPYzXSbPVGMopHvxPxQ51
         sdV5GgJgA9Az7I4ciBT6YXFRMfraH2vZz5dEWsWdOiFW7IhTLhB7MtUoZies6/Gudw4a
         6Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vR6QyTXKzjneeimQgI3lYac2uhU+48R8rf60k+wC+NM=;
        b=wzi+ZGSqZxpDavV6FrVN81NDar/nxMAvU3cFfPXneYYxVUux153e5z94ak+nTy5JnM
         S6BKLC+3Kna6N0HxOokxfpqdwX5lLCUkk/Ttqx96vrtgK40ZIKnb3FNhmAVjUrvuzxa/
         ZutohdOfL2rYvdHT8VcAWyi5BnOpcWvVcBsgE+d/sFowgF6jfXFXIWdyMDiwe2I/O16b
         PYhpqYGL2RdnCdd82p6jhRT6HVwQL3D084o9cXsvc4yG1chAeFmWItbsOaFLCrNQEsOf
         vs/5cD6e+4BBaeiyFDjQhF8FbR/r9Vjcbb5O61s1f+1YF0ziDqrJEUzWkeL8qXurcBhs
         xEOw==
X-Gm-Message-State: AOAM530D28H6El8qNvHAHTytGg5anRIjD1P5hhksugR76LtsaaNd8yz7
        yVkvT27hG7ZIstmTVO+CyGdEhw==
X-Google-Smtp-Source: ABdhPJxy5Rbwg1eY20BNgqRD5xxDnNA3PThlSvyPpivCD2BUoRplRnX1hWPmo7UhMrbaXgw37YMxHA==
X-Received: by 2002:a50:baa8:0:b0:415:b0bc:6353 with SMTP id x37-20020a50baa8000000b00415b0bc6353mr13999510ede.220.1650800589299;
        Sun, 24 Apr 2022 04:43:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id o3-20020aa7c7c3000000b0042237eda622sm3189324eds.83.2022.04.24.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 04:43:08 -0700 (PDT)
Date:   Sun, 24 Apr 2022 19:43:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, kan.liang@linux.intel.com,
        Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220424114302.GB978927@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 05:53:28AM -0700, Andi Kleen wrote:
> 
> > Except SNOOPX_FWD means a no modified cache snooping, it also means it's
> > a cache conherency from *remote* socket.  This is quite different from we
> > define SNOOPX_PEER, which only snoop from peer CPU or clusters.
> > 
> > If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
> > this would be easier for us to distinguish the semantics and support the
> > statistics for SNOOPX_FWD and SNOOPX_PEER separately.
> > 
> > I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.
> 
> Yes seems better to keep using a separate flag if they don't exactly match.
> 
> It's not that we're short on flags anyways.

Thanks for confirmation.

Leo
