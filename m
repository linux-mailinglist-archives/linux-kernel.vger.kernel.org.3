Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA0546379
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiFJKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbiFJKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F07C8F59E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654856635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBWzJ866AM+Y7b20yDiAy0K8AX/FzXkiVcE0IEQfAYo=;
        b=NprJjJtYbHU7C82gX2gFh6yGELu/7p1cxJ4ViAQ8cXqFY/UOmAAErqIIZ/s2F03NGcZTpH
        uQWTkYoCldGJFtVn1oaR29h7Fxt4yj7fCAbTPiPaM67Xiuchelaw/SXWB3xAOl8dfhDOgE
        DFVdYxgAsa95pyFdZ5Srv/AsVj+2gCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-F2U_YBMpNg2zFTTlWvYA2A-1; Fri, 10 Jun 2022 06:23:53 -0400
X-MC-Unique: F2U_YBMpNg2zFTTlWvYA2A-1
Received: by mail-wr1-f72.google.com with SMTP id e15-20020adfa44f000000b00219ebf65301so128343wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CBWzJ866AM+Y7b20yDiAy0K8AX/FzXkiVcE0IEQfAYo=;
        b=DJlyzm/suberQ70lucx9HPZf1WhYdIoViY78tdf1+SDVVLuM1zGmx8NARwc9yFVeKj
         eR5Np6nxFGpAwz2YJ33sApwRiPN0/VCKR0lpECdvceo10JXps6EcxedeFwe0so9pTSlf
         PPbjq1D2gbXtyAUwtpQ8OfbG5GBgHC0ujSmxuKkdXEf/TexFrgx3GY1nnEMfTLlI1P16
         4w2vKVSAPgNa0iZ/EpHgA7zHlFEb7cmCV94WQvCXyG4Xwus7ZFktT238rL8xW09NxdVN
         wxOL/KWqFK7sc59QImyc0jy3z7dagzMN3F9VKupts9VlcKJvGfuuYujxpToDnF7iNkdx
         7Z2Q==
X-Gm-Message-State: AOAM530xMN24d4wI2rx7N8vTmfz6I6c486/bIPswDKkZyM8jjJ3HR1FI
        PRSegpZMDQ29WXDn+uQNDGkYObngm8BMo5FX4A6cYJDIKDZ2lgxQMFE+/ehVjowemyzeP3TluMs
        2U55PpmH2rm/kUWH/u/3IvmN6
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id s16-20020adfea90000000b00215a11d3329mr35764989wrm.709.1654856632718;
        Fri, 10 Jun 2022 03:23:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygOXm78PdV3NRNjGdnS3hkZr0xgsCq6zU3knxE5/Qq7Xmj9bnnODSMGiTUkruyArOv3/mvBA==
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id s16-20020adfea90000000b00215a11d3329mr35764970wrm.709.1654856632500;
        Fri, 10 Jun 2022 03:23:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1f00:4727:6420:1d4d:ca23? (p200300cbc7051f00472764201d4dca23.dip0.t-ipconnect.de. [2003:cb:c705:1f00:4727:6420:1d4d:ca23])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b0020d09f0b766sm26218887wrw.71.2022.06.10.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:23:51 -0700 (PDT)
Message-ID: <05623846-03c7-89f1-e1dd-0ee23723c7e9@redhat.com>
Date:   Fri, 10 Jun 2022 12:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] resource: re-factor page_is_ram()
Content-Language: en-US
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 18:32, Vaibhav Jain wrote:
> Presently page_is_ram() relies on walk_system_ram_range() that performs a walk
> on kernel iomem resources hierarchy with a dummy callback __is_ram(). Before
> calling find_next_iomem_res(), walk_system_ram_range() does some book-keeping
> which can be avoided for page_is_ram() use-case.
> 
> Hence this patch proposes to update page_is_ram() to directly call
> find_next_iomem_res() with minimal book-keeping needed.

I consider the code harder to get compared to just reusing the
more-generic and expressive walk_system_ram_range().

It somehow feels like we're duplicating the code here just to optimize
out a handful of instructions.

If it doesn't make the code easier to read (at least for me), why do we
care?

-- 
Thanks,

David / dhildenb

