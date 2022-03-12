Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2B4D6D62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiCLICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiCLICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:02:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485C1C60F9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647072064; x=1678608064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uvjzLtZ0QuVOYXq3pO1ebVjYlGHyAzBNRpNQOKxDX9s=;
  b=LarX5XsXB8sPDo5gIMusJCmNLBvo685ybo6jIoezascjErK6ze0l4Nzy
   CGRYn7GM8b4YTFVEBCVN4QiQwlb7NM1IuD3C1yqkTLopVjQwBnZ220+oC
   /EtKqTih0myERr2z/lOobtqGfgh8IizeAYfcmIXLqE1F/d1UE9XqQHW6x
   A7/DqCk7Mv5ZKdmYamxoscFH1lila4LxC2TW6qzNIgX6PBjOsUQqCwOHp
   +AtWYa1LgCQooM33uCPIRSqXnlFlbQ/MY8kFXNPnC4afqHBkGDBF+3K1a
   7UJm3o4y6DQXIWlSntjnGPlJ3k2sNx+oLDTfrfh1dxILehR8kKhQu2I52
   w==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="196114303"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:01:00 +0800
IronPort-SDR: ejP/UPf2BsZiUwFHaVf7ULZWYw2V453gPYOffJ6OTd9v2OB7zN7vFsL+dFvbyHv7GQccq53Z04
 EbRSNuJm/ecslTTDtAo+noxlPWNYCieLV+fYuNyVnGKCcG48bMQ/LkrVLNM9tipODizAsG8tIe
 1mOOsXcdi1BYhYNyPd6XoVWc6hgYHaB/kD7jRxQhmZOVwFA4C5nhRfMaj0shz2FzNZk6iiujmR
 qQ3ydRlwPdQDlBat+Xtp7ayOESRuoM5hsWGusLJvWtqOwIeY/z5ptE7AokalvYqKEJ0zM9E6LM
 l3JMwlXw0WcKmcXd2Sn9j7Vy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:32:11 -0800
IronPort-SDR: ctcaBNOXndT3GdOsxrlAnHXrowdnF8dojeMo0z10iBxCv9vhKdeo5BN1v1GplUUID+nAOr/k36
 aPnWN7VH1jar5c2YBh+pDdep8rWWDKpKKmCRx4M0YvLn+vYR13BUVbHvKFhoVDHtGnlFT6IkQ2
 RNB36HTsk34yu6fkoPMhSAffc9oDb1CeMc3sZY2+7996aUWPzFaciZTunwGa36OmDemEkJMHey
 gbEKmVxvi9p2gPiZnCBBcDBVbf6uCDpE2X3g+UuhbgdaaMBZPrAnAXduvTnjfn+fDcJv4S9x2l
 uOA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:01:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwGg2hZJz1SVp7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:00:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647072058; x=1649664059; bh=uvjzLtZ0QuVOYXq3pO1ebVjYlGHyAzBNRpN
        QOKxDX9s=; b=iexa23W1/b63APqV1nvtJ167i3NiHrMLOssPjIe61Q5MWZCyrZC
        T+x9sfu3duuK4dGzJ/3yFI4znEotyFG+2ctKGCKog6T3KNbxW/iWf11PVkr11nYy
        H3PHQP7E/lr73gpt9IVMqsHP2NYYlcShwK9KcovY3U4FjufSGAXJ/nRq9uMS+Sud
        R8XKypwhjWPNDMBt3AUJr44DaGNeVgPGd8OTXvwVMIo8L6qOtw5dTNYSDgAn8NZB
        AWdLiFRqz/jgad+8/u7f5c2DeYqNuUbRweaCobNWnp8a7Bb8roPTnMJfiOuRaDIS
        DbA1s65d0xHQgdeHrBWi3pCZ1N+aXwEurzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fQGoR0pfL38g for <linux-kernel@vger.kernel.org>;
        Sat, 12 Mar 2022 00:00:58 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwGb0tYyz1Rvlx;
        Sat, 12 Mar 2022 00:00:54 -0800 (PST)
Message-ID: <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 17:00:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 0/6] Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220311210357.222830-1-linux@fw-web.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311210357.222830-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 06:03, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This Series converts the binding for ahci-platform to yaml and adds
> sata nodes to rockchip rk356x device trees.

Rob,

I saw you took patches 1, 4 and 5. What about the others ? Are you
taking them or should I take them through the ATA tree ?


-- 
Damien Le Moal
Western Digital Research
