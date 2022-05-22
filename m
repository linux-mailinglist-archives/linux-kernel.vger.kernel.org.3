Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB7530686
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbiEVWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351656AbiEVWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:22:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F4240B3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653258161; x=1684794161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g7+JeN4wnrl6dFXGk3nhuKNxU3bxTCBHH+iqteHxNFE=;
  b=aiG7A8mIQ/6LTz1MFnlwjLHAuXEeXKHQtQVPNeAVkmktwPVI4JCFvEY4
   FwC+jBTZ5wNkAl2Vh3ALSggdKJuWW+gY/fO0hqMMCSSEn44isE2UogOY7
   TxUs+aZywUMnJLvYcGTfglyjei7wwZTrHpgdxG7zbIa9Vm43W+cmWPpdo
   jyWzDg3HE/mk6RY8JndtcE/dud+3cRiYKiDv+UVQKaF1sufu1WyO+lksW
   ubyN8hYbilMhYnmNdIm/XgvoMl7V7FVTahHALl7MXZ43GO2xJK2CNFy+5
   tXxj2QtHYxNySxJnAnHkOf33WJ/9+Ly/Xoqelq/6dxfQwcsXbK/zsGS5D
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,244,1647273600"; 
   d="scan'208";a="305310281"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 06:22:41 +0800
IronPort-SDR: S1AHv3mqrpOUv+UE3HqBdRmXJ3wDECOA92ji1ebQZ0yHPjfJ7s4qL66oQXubKNRRv5+JI7BZgu
 ZA8hLku1nCET/GUpB9gNmxC59UUFtiiNsVVyRKscvDP/a7OL5ZqvxXgNat/6MCC7BoG5G/u7lC
 oyCIq+jIpE/YTLSZlZVc6xSoMJHWqt9hrBnR9CteJnyLyVOcY1IBy5scg8Gs9psGN+RfW5VRBi
 1e30sQ1hm3t7Z4F+uioVuhfFs92py/HFEPTLvEh2E1lOniCn/XCqRQ5KpsR+yTr1xIgWJj3ZlN
 o05MiROhyIWMaceKbmDfZrLo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 14:42:15 -0700
IronPort-SDR: GRHntdSqERYAP6eBKW1VzQ/oDXaLLKgNsjQrMO8i2BmQTvMnCNe6S5cwRTxvWBfMTnHIf0yy+C
 wpx9efRXBy/QkTtJJX+3AGytek3BxTUQwtJrtEEb+kVFx79k2E6eoJA+bzXa4lNnTcyN7e2WRo
 QswRZ/ezRF7iaHr124EYiazUhQSQZXqsLYdD3QgwwWtiD6uVby1mfiY4eLuIaIndaRKE4Hb1C4
 PrZlyAeKUWwMnYvsUqIM/PiZC9glpHKDz7nd642hz81t0OfnBEhe6Uq0m01Bhr9l0V09vwjO5u
 n5E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 15:22:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L5w283qcZz1SVp0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:22:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653258159; x=1655850160; bh=g7+JeN4wnrl6dFXGk3nhuKNxU3bxTCBHH+i
        qteHxNFE=; b=cFP8EjCWYzIn0k4ie3WKPohm2MCo0AumuYqBQTKCtVbOnF5ahgC
        3DMD77wHEBGNIby9QYVO8Kyj8ThYO13/AhkkmwvMo1hw6M+usps0UivIXgCdZseU
        9A6F5n+Fh6VrhIr7wexiIbbqwP/tasyeStlJ/r5Q78CNt8JpJvfsexJ4TyKQTbY2
        aY7WAwIjYDT4mh9L4oSbx4j06Oa3+BPww0WpgkiA5gn05hxU90tfn4OZw+TdYdiC
        O82vY1I2LjR+sEaV1nVlyE1A1wP+OTnEVYJ/WTGpbJJtbREAsy8XMVCmYRSC0I1S
        oStpPqSyJ5iYY82wZ98GYO9okFFzZCtC3dw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XQuAJeThsBXc for <linux-kernel@vger.kernel.org>;
        Sun, 22 May 2022 15:22:39 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L5w252KbGz1Rvlc;
        Sun, 22 May 2022 15:22:37 -0700 (PDT)
Message-ID: <15f94ea2-fa97-3122-60dd-a87a3dd8a7db@opensource.wdc.com>
Date:   Mon, 23 May 2022 07:22:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 0/4] DMA mapping changes for SCSI core
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
        liyihang6@hisilicon.com, chenxiang66@hisilicon.com,
        thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <20220522131345.GB25785@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220522131345.GB25785@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/22 22:13, Christoph Hellwig wrote:
> The whole series looks fine to me.  I'll happily queue it up in the
> dma-mapping tree if the SCSI and ATA maintainers are ok with that.
> 

Fine with me. I sent an acked-by for the libata bit.

-- 
Damien Le Moal
Western Digital Research
