Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D658983C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiHDHSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHDHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:18:07 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8855C969;
        Thu,  4 Aug 2022 00:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659597467; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RitbPrTTslmZ0rPk5lvqDAN+IY0eVaS9hFna7Pc9GW8iD/DSs4WLGyXaWsKTh/h0Sv33aOR5AKW24q5Wdl5EHivYpMvkPAWXQNTFV3+W0amucqlIcsHJ4Xb2tiUXzQENIRGJtOAjuFEzX32ExVYJUGDInOgN47mo3zG2/E4EVSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1659597467; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MCrWicY2XoCiSIKwKmcXAPX12IeBhhZabwszQBGvXqM=; 
        b=iY2LdKOooPCVsRu0qmwu0I9Cx/CBcCd9k8jYRS6LJNNkkFSPKdLwHklx5s00McmgtKg640Tts/KS0u2P0ofjFHS2D1tfcli7+pntpEej22Djx7zOwIpm/mYQp3+SLcg4lSrLiP6ojYgcObuyF1L1VxjFqfLYZnpKm4tfo82WuhE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659597467;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=MCrWicY2XoCiSIKwKmcXAPX12IeBhhZabwszQBGvXqM=;
        b=LJu2o83LsU5SFrXTdMic49rOunqaJpFgFtVKLTdIhRbHvgZsJKMunXpMjLk2r69R
        e05WmXzI1FCI9X/uubv2HxT4UUHLv0f9c+S719GbZWyuB7h3iO/VAFUZ9TQJF5SDCWa
        oR+tXlOIPNnOqnpIGDgCf7wN4DpfEGJr9fukWZxg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1659597465146222.34603720111716; Thu, 4 Aug 2022 00:17:45 -0700 (PDT)
Date:   Thu, 04 Aug 2022 16:17:45 +0900
From:   Li Chen <me@linux.beauty>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Li Chen" <lchen@ambarella.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Linux-MM" <linux-mm@kvack.org>
Message-ID: <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty>
In-Reply-To: <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com> <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty> <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
---- On Tue, 12 Jul 2022 16:50:46 +0900  Arnd Bergmann  wrote --- 
 > Does your hardware require a fixed address for the buffer? If it can be
 > anywhere in memory (or at least within a certain range) but just has to
 > be physically contiguous, the normal way would be to use a CMA area
 > to allocate from, which gives you 'struct page' backed pages.

CMA does support Direct I/O, but it has its own issue: 
It does not guarantee that the memory previously borrowed by the OS will be returned to the device.

We've been plagued by examples like this in the past:
Many other kernel modules/subsystems have already allocated much memory from both non-CMA and CMA memory,
When our DSP driver got probed then, cma_alloc will fail in that non-CMA system memory is not enough
for CMA memory to migrate.  

Regards,
Li
