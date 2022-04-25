Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2E50DADA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiDYIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiDYIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A726426F7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650873871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8f4fE6IYdVj/twVD/+DJWond2u+iNcuU3vy06rRPI4=;
        b=AIhreeQ2+xiPAh1H5aP1C0thn3wJAhKZNE3d2nwcvO5/1vZP+OZOXORX+pKJkzhRk/tDi1
        sQ70zg0OuIxfk1r3i0/sHT9iCLJHQ5F5C1AHunrNvTTjm/iMm+J1UdAS4ubplkThcWl10W
        /nXotVZcXx+bxTuD6uwMAm0FDbn+3w0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-RrsEGXsfOkugEmK_aTjlrQ-1; Mon, 25 Apr 2022 04:04:30 -0400
X-MC-Unique: RrsEGXsfOkugEmK_aTjlrQ-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso6855385wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N8f4fE6IYdVj/twVD/+DJWond2u+iNcuU3vy06rRPI4=;
        b=VySoC5EydWB5ozU4Uoxx/QdCTYBOiYTbJbbujxKp6zRnlXDlvvaJyGbViQdr7N5Xy+
         eJXvNvCz4f6C5I2kYDGZ/89umfWsQXaCQaqcP45OgQv+D5eK/YLTWZ9ZN9QkuWx1LEji
         6BkNSsEljmDSSjXbAxS8Z+FMakcDskTVWop3mutjRE1MFWQh+24lYV7Hzw97WisjDMmG
         auQHFUsUb3ZolCpCzlIIur+RP4ELbuPEBqEZHACFpp/xuqanUUUYFG6bHb+Ue+1/piWc
         Ph2tS2owuqSmwi49Zs4vPPNF2LAlNmxNTSZncNBepYHSRPI89Lyx1TQweyXzQKX0n8Fj
         kJTA==
X-Gm-Message-State: AOAM531gkAZb1czusic+uo1mZACYR9+r2zCazewCtHgZPJFTOoLTVHcw
        GR+aQftnn44uTwXs8e6BMLaG0B97QRkYGWF2eQKuvYcFwPyzRtL8l/XXXkE/gXNbhKmOf0k4IdT
        7MrGd2VJlOkkGBXawZ0NGqq+f
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr13454295wrf.54.1650873869298;
        Mon, 25 Apr 2022 01:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHXd+uZj5EXJCQ4ArjuZpEu8IU9qMfpi/Bi4crZ1SrHy3v7d6AifKMd/UoRx5duNYkxn3anw==
X-Received: by 2002:a5d:5889:0:b0:20a:9707:39c with SMTP id n9-20020a5d5889000000b0020a9707039cmr13454283wrf.54.1650873869034;
        Mon, 25 Apr 2022 01:04:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm8402748wra.96.2022.04.25.01.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:04:28 -0700 (PDT)
Message-ID: <1d67fd1c-29d8-d5a6-4d36-17fd238385cd@redhat.com>
Date:   Mon, 25 Apr 2022 10:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [hnaz-mm:master 34/291] WARNING: modpost:
 vmlinux.o(.data+0x234bc8): Section mismatch in reference from the variable
 fc2580_driver to the function .init.text:set_reset_devices()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202204241241.dnUrBBvT-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202204241241.dnUrBBvT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.22 06:21, kernel test robot wrote:
> tree:   https://github.com/hnaz/linux-mm master
> head:   ba42854fa9997614e0ffdbc35b082df3ba6e59da
> commit: 477a4d0f1f38e738d1a50d5005b79aca719c30bc [34/291] mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
> config: riscv-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220424/202204241241.dnUrBBvT-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/hnaz/linux-mm/commit/477a4d0f1f38e738d1a50d5005b79aca719c30bc
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout 477a4d0f1f38e738d1a50d5005b79aca719c30bc
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> WARNING: modpost: vmlinux.o(.data+0x234bc8): Section mismatch in reference from the variable fc2580_driver to the function .init.text:set_reset_devices()
> The variable fc2580_driver references
> the function __init set_reset_devices()
> If the reference is valid then annotate the
> variable with or __refdata (see linux/init.h) or name the variable:

I don't see my patch causing that. Seems unrelated.

-- 
Thanks,

David / dhildenb

