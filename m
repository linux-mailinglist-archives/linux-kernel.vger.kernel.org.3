Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030DD5389FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiEaCl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiEaCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:41:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC36470E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:41:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so1084488pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIykAolW8oD8LFPh4Udn9DG3dxOjaYMmjkMXBAWVxpo=;
        b=CVvHshPmWe5jCs0Mr68BDf13AhiQ8GO1RiUsqz9ayy5G3PLHWwFT6IVjix8wcfVer0
         Sr9uJ6gHPENKEjoYvdndsdMqjXN7xLl2X6LBKbXVBKy9Eo81FCqTxCj20I8tEbz5OiQ9
         mHQEXfEXwCE+8oE69xMvQI+P4rjZIj9HnOYz/dl5FfacUWhjCfJ9FJDjlWQwpa5vuEaN
         E17cHocwf2mruriEmThiB9TnOC3368ZoswnYDkhPRnNUbuYPS7s8/0KajLK5DmYuLtjI
         GRtOsmafbjLyeaeH50XZGHpp5wPxbIzXuMyfUajM0D1TNm0S/o8JIGj16kRu8Wkp6g1p
         ITpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIykAolW8oD8LFPh4Udn9DG3dxOjaYMmjkMXBAWVxpo=;
        b=lv4e8FVR1YA8OkYfav5SejSaB7RYLwSEEsWRFybxtPVNfrZeKH5b5nXeVMYgnS6LTp
         Nzu+wEZw0VaTcV0S3aA+7+82Tpln/CMS6ANwFb5F/NxOg9yF3+ILffz0I+QxEZxynAoD
         GsVTP0TgONSkHjZKwzKvPn5SvMSiaeavE4Wx2Y5xQ+olnrFOT86Dzq4tqUbH2KUx30SY
         NNYDwAlND1v/77oicBhjxqOXP2bFoc5UVZwZOqXTAOdKE/18Z2+WHlO33ySx6ZlaBv3x
         dcetbuwJtkmmmFgRO3PbXdGck03V6WtC9ao8ezTN03w5coeA4cWvrHUrSw6qaoO9BThX
         bxiQ==
X-Gm-Message-State: AOAM533PfjWelkusSKbUyLT1zCUg+UhIvLfUYRWhpt8zSMsKKY8PN3/q
        NZ13RxV4EFOIgc4oWNj7NK4puQ==
X-Google-Smtp-Source: ABdhPJxw1Wrte9hUOu30NisM+OaPV6N/2l5jqTiV5IBAcuZXje+ObEShiKQ+nAxZJCcnoNftzu0B0g==
X-Received: by 2002:a17:903:2443:b0:162:223c:c0e9 with SMTP id l3-20020a170903244300b00162223cc0e9mr40921952pls.68.1653964886485;
        Mon, 30 May 2022 19:41:26 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id e7-20020a170903240700b0015e8d4eb2d3sm9872570plo.285.2022.05.30.19.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:41:25 -0700 (PDT)
Date:   Tue, 31 May 2022 10:41:22 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH] mm/slub: Simplify __kmem_cache_alias()
Message-ID: <YpWAUiwNPpO8l6yh@FVFYT0MHHV2J.googleapis.com>
References: <20220531005550.10613-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531005550.10613-1-sxwjean@me.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 08:55:50AM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> There is no need to do anything if sysfs_slab_alias() return nonzero
> value after getting a mergeable cache.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
