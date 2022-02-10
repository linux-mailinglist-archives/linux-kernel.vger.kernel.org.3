Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F194B0BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiBJLEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:04:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiBJLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84B77100B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644491072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=912gx4l8B914qXTe9ZjzFhB65u3s+B2paBTlsF2z1ag=;
        b=PVoQUHDVPug+U+m9s0XrwBsqSDLvSe3xXSH7R7NTNs61r936T79OocwcFXuybkhFCwT+Kj
        KJpsDz2jzBkwceDIv8ADX0UT2PfaXUhnhVXzH3fDum6N6SjI0Sz7VRDy3+AMp/ZpGpfS1P
        7+9XCH0kOPfEZWMJ81fZ56UOjPxgcQo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-SJc_f_JOPV2D4ByfYMOccA-1; Thu, 10 Feb 2022 06:04:31 -0500
X-MC-Unique: SJc_f_JOPV2D4ByfYMOccA-1
Received: by mail-wr1-f71.google.com with SMTP id h24-20020adfaa98000000b001e33eb81e71so2348904wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=912gx4l8B914qXTe9ZjzFhB65u3s+B2paBTlsF2z1ag=;
        b=FE8O/7SS01JW3HH3yVHwj0aWVdnItAlEKSE5k9tmcPtPHmjl/wSf5BUNVrPJu4KoyR
         MrIqSEPLt2OHrKTy2bvhWGVLeyx2TcG0vRLiZpRDyPZXrAqcdRaOjKKVrD7D3z0o/BHb
         /t0j/uMEyVuye48zWf8hQvPTpCzQzdFnPvslotyMgh9m+a6pRtN1DHk/Rj+o3n2L7t37
         8vS42vCyzVENo3kPdq5ywM2ee2riTyLO5q/0F9MKz+6sWfpBcf8u5fcoYeN7bJstK6dP
         +ExQy/RCASk8tERaiV9fLs7s03F3f2rO0qnfvlRiz3/JUYTRqQeCAKtwT5At+42PuKyW
         JiRA==
X-Gm-Message-State: AOAM532l2/9E8nQn5bkirVCWyLbrPu8kdWmvPE5f7RmiRF3d3ljIPgpr
        4acFsfiLx20pNCFxNnjB+1jXcJGBxdKQXLzBgdPm05w1oBpxInfgAeqTLOGZaRTQPNkjLjA6CG+
        5Gi0YToCKCCkUiQkG7HtztlJm
X-Received: by 2002:a5d:6090:: with SMTP id w16mr5795775wrt.250.1644491070277;
        Thu, 10 Feb 2022 03:04:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJBi0FaA2kpZ+9gAipQwSIBhfk2Tp8z4y5Nuyr3Qb6xYWh/85bR+5Pqm58wNckCW5VmxgUvw==
X-Received: by 2002:a5d:6090:: with SMTP id w16mr5795750wrt.250.1644491070061;
        Thu, 10 Feb 2022 03:04:30 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id g9sm19432968wri.95.2022.02.10.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 03:04:29 -0800 (PST)
Message-ID: <41e393e3eb7d2909130906954309acfe980238db.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        akpm@linux-foundation.org, mtosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Thu, 10 Feb 2022 12:04:28 +0100
In-Reply-To: <8cf34eed-be5a-1aae-0523-c2de9e087cb6@huawei.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <8cf34eed-be5a-1aae-0523-c2de9e087cb6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-10 at 18:59 +0800, Xiongfeng Wang wrote:
> Hi Nicolas,
> 
> I found there are several 'lru_add_drain_per_cpu()' worker thread on the
> NOHZ_FULL CPUs. I am just wondering do you have plan to add support for remote
> per-cpu LRU pagevec drain ?

Yes, this is something we've been meaning to fix too. But haven't started
looking into it yet (maybe Marcelo can contradict me here).

Regards,
Nicolas

