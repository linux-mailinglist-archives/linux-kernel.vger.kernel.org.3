Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053751CEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387947AbiEFBgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351319AbiEFBgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:36:02 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C781EEC7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:32:21 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-edeb6c3642so5925141fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=068F+h8RQfUvOVO1t4k8OZXqnvKUCyKIVv9Y/xDcfUE=;
        b=X5LjzzrJPRILUj2wePdckLtkz/yTAOqqlWhNuos29HgZKVERn5uPygdpkEd7Or71yL
         elGUCzpyV/JjsRz0SAB2nmrME7scMN0yoWb0QEG26w+WM3A0fx5DwIKj7ZDatndOD/rU
         csRJ3qwoP/K+yJK1Abk6vIZCVNLHDfqqKe0sJlcZfpXpnHYo2uzpR9EHZRgL9q7Kmzwk
         sr/vSoRnWjKthofCIScEFvjnCb0C4h4xMDEj34gmd7bhr5dFigfK5nwGjqayrUogWgUy
         SZf8NU6wAlv9Sysds9a2iEZ+hUy6pcLCFgY7L0+WotCDwALnOEDjqLcaiAqPSuQI6j7K
         XYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=068F+h8RQfUvOVO1t4k8OZXqnvKUCyKIVv9Y/xDcfUE=;
        b=fsbyLLMa8K8zunxs2GAXSmHnEIRwNEN8tDdikBLZ3jli6dk0voxeYQrWfuKIi+SP8t
         MStDmvOT1NpD3eC3G2Gfm7WJrDPP9y2Dd751MMawEFDGTQTJMUoGPtle8LC7na3l/Rg5
         m2GiZticL3MB39VwxdQ9cfgc9lpTpOd/nfo3Mp2VnZnQzqmhanz5pkX9628+iUNFzr81
         Up5iM48SLjuAP0ZmrafgbNd8ZtQW0O4M/BjfNjeJm3ckNq1+1d2v4PfUDB1tmcuXNz69
         e4e6Ru6SQn0PVC4VSIeosuLjlX1FGvCQG9VNokPxcYFPW8fqr6IWzvn3/A1m960RapWp
         k3vQ==
X-Gm-Message-State: AOAM533q06bIoDvqqtSBTbfQZB5AePtvkVyAdIvuBVvq03tf6WpUg/jA
        +gR36aHYbG6mfoaeUpeQGnP7Tg==
X-Google-Smtp-Source: ABdhPJw7EpOD9gz0ff27qFrh6p53w00QVueh6ajPyfZRMU6f46uyyPmO+pPTTLpC3Ni/FuWHCI8UPA==
X-Received: by 2002:a05:6870:d0cf:b0:ec:4559:86e1 with SMTP id k15-20020a056870d0cf00b000ec455986e1mr373763oaa.225.1651800740991;
        Thu, 05 May 2022 18:32:20 -0700 (PDT)
Received: from pop-os.localdomain ([2600:1700:1d10:5830:1761:845b:ca10:1b4d])
        by smtp.gmail.com with ESMTPSA id x4-20020a9d2084000000b006060322127csm1133944ota.76.2022.05.05.18.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 18:32:20 -0700 (PDT)
Date:   Thu, 5 May 2022 21:32:17 -0400
From:   Milan Landaverde <milan@mdaverde.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH] bpftool: Use sysfs vmlinux when dumping BTF by ID
Message-ID: <YnR6oWaoUkEGW1iV@pop-os.localdomain>
References: <20220428110839.111042-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428110839.111042-1-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! Just ran into this. I think we also need to pass in errno
here to strerror instead of err:

On Thu, Apr 28, 2022 at 01:08:40PM +0200, Larysa Zaremba wrote:
>  		if (err) {
>  			p_err("get btf by id (%u): %s", btf_id, strerror(err));
>  			goto done;
>

Currently, the error output without a base btf reads:

$ bpftool btf dump id 816
Error: get btf by id (816): Unknown error -22

When it should (or at least intends to) read:

$ bpftool btf dump id 816
Error: get btf by id (816): Invalid argument

I was going to send this patch but if a v2 is going to be sent, figured
I mention it. Thanks!
