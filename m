Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9B048A415
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiAJX7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:59:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11229 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345791AbiAJX7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641859160; x=1673395160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M0O7YVD0mLk5LBqZhjWyuOp/++cCM2PQFruW/QrbzMk=;
  b=QlSMNZmF+/M7YIWmq6ZrF4BWYvecVDFxljOPkxPUmlLWdP8wy9Kw0Ri3
   L9gDvEnqieVbrT93K+AwCzvD2n3S3l3AdUsGMTDK+o28GaEdBwttDJmAd
   T5OrDh76x0N0mL28qIHFpXqU0HKN5SbsP2EJvIBuk8EqDRHJrv4JLE3z9
   I5gQza/qy7amfZQJalWpLKacohSXGilePUj1B3LeK/kVmgrQUKHwN3TKp
   pRZOdnN0wdLsCpOc8oKr0hEuXrTIAtdCu9rtO1gwOJG64fxASlH2s/4sz
   RuArknzVnkRQxS8srGycMuqctzzyPlnDTXlPPqKLJYuyVS4TmmD7cl3kr
   A==;
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="194933220"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2022 07:59:19 +0800
IronPort-SDR: B6uL0nm+2zVeZE0Gxb9A7Otk/kIfaQrUmjZnyzva+8jqn/X9K+NTqZ9Z1LyK7DgdhyIUjLU8I2
 z0qmFxljCMjkyYU/YMynM1B17akFwjDMOybe6L4gJXQ1f72NjJv+8/fInlmGF6IA+prFarNvzk
 HVmV005gtnCRJT6ypW7cIhLyigwbD/k9NU0gmsfGs1YqRTcIB3he4Y98cvLc/2JP86IqtdgjT1
 KItFx3aa8dZMgpvBPhQRTO5visQ8rkGDhJ9RgcfCiClJdBCvrSh36zyWXXFpmrZjsrM435ekNH
 iinK7GDvD4nm9x5VJA1RvsEK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:33:03 -0800
IronPort-SDR: tcy+zLByjFT+vCxV8+xGnQT4uffDqna6HT4SWlR0r6XeAXlnbMAjcTxPUJhVEPNZ1PxQtFscOg
 sywAo5AQkTHJHAWjPCy9vpvjbJVQ5ydvURMLztcgB9ZHtv99/RwuxVVI75GB4idb8MyYD/E/Oc
 3hQo41/ZvjfxsXY5yb3IhKtBYHHfKgRvAv4ZozBlKC0WLi4bHOA6qp1XEjnitUas0/mncfd05g
 QA+odR4ZkzcHuEMMW2kRfzZ0zMo2/aNC/cqhrtfqrEg9lnQsnXAOXxscVfOfgJgfVzEYmsx5r6
 2+U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:59:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JXrQc2fKRz1VSkf
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:59:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641859159; x=1644451160; bh=M0O7YVD0mLk5LBqZhjWyuOp/++cCM2PQFru
        W/QrbzMk=; b=F5n2Tljt7/3qPHeVw/BFUZkA3YEmAy96VyIwIrQQ6TomJG0bfyu
        658/nDhvEzWc9fvr/8IZhdJCNBiHJxTaDWHCPxlrszSk+VJQqVIjBYEY2fP3FHXl
        Xcij2Glt2kpa+BBzt/jWc4Ne9Ci3aDR6j7Hszj53nxgvDFNWm3q84PDsFJtGq9Zm
        lW6e+ZCiTiMPwEueWy+iCMdLumcLqg5mYawzq2RegWW1jO044YbeG+dRfus//JDG
        XLmeORy2qnLrisqQGrS3m+DA5hMmq4R56JNHyJo4Xgb7lEoQx2txJLJjhVjD3Cu5
        37PTlRbD1awIY/CO7PMc7cvEC0mEFYEQijQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZMUjsdeuu2XY for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jan 2022 15:59:19 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JXrQb0HFBz1VSkV;
        Mon, 10 Jan 2022 15:59:18 -0800 (PST)
Message-ID: <5b404e0e-837f-4e97-857f-542bd0b1e48e@opensource.wdc.com>
Date:   Tue, 11 Jan 2022 08:59:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] ata: libata-scsi: simplify __ata_scsi_queuecmd()
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <20220106001354.2029046-1-haowenchao@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220106001354.2029046-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 09:13, Wenchao Hao wrote:
> This is just a clean code. Since each branch of "if" state would check
> scmd->cmd_len, so move the check of scmd->cmd_len out of "if" state to
> simplify parameters check.
> 
> After the check of scmd->cmd_len is out of "if" state, we can remove
> one redundant "if" state.
> 
> Remove a redundant variable "rc" by hand.
> 
> This patch do not change origin function logic.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>

Applied to for-5.17 with some changes to the commit message to clarify
the changes.
Thanks.

-- 
Damien Le Moal
Western Digital Research
