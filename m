Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1252CA08
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiESDIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiESDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:08:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE5D410B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652929714; x=1684465714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJSBsvKlJE=;
  b=f4/Fo/cXzAKTyM1mXOQeYpGSlEnDsE2J3w/ocLvJLgD9lclvg539Z4zJ
   n02tU2+0iJeXpJfeThCksB0VZK0rHwPghrt3zoGAqdOIK9RJh+8lOMwi4
   D8NUF6YdoTjkhuGKqr7JWWvBx27En9Q9qv9ftosIzb8/D+e/o/aI8115D
   SyFujamr+Wsvtkr5HeUcUPuvKnrvfHBVy/h5fC/ehcQl+EQNN1esR8JM0
   wYUSyGi22TBe/4EQWAYqSk4WlEjXm7LOqc/tnSCPIv6K2ebUNjKH4L1K9
   iFpGdFJvMNbTgCDPTSfyzGnzJ+1z8XT5zBCkaOL9cCzuF5FrXU0bouAod
   g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="199556798"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:08:32 +0800
IronPort-SDR: yj+nUFHa0fDMfIsDWlaqIBj/W28BRt4qwh6P7w34v9VLWMKBjqqcysfnUZ01F03gZwcFbDrlRO
 VmuTJtvPRUrSfzkdF4nhtDSjr/aqD0Fh4Cn8F6RSruagnpYUbLimfCfRmBE+Lu5o35AJl4ujAR
 uaWmXllc3QVn8qnYKP0/ijU8ABWaf2QUI5v9nL9TzFQ0u3wTGt1LkFAxi1zawueyjlcpRaIKB5
 vPNYtw3n9QLnYq0yupNvc+Grk7v/aKF3huPKJSThroz6DBHG4jUTqCyRHFTYsCbGCP69QBApKd
 +hrIfhaPIRcYh/vSoQEb4EX7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 19:31:34 -0700
IronPort-SDR: U+7F6xqASNwlCRXNbXnL2QUJnpfadqG7NMVDGPcUMskpUbTis4t4P+LY38qWcXdbJpKTcFg0h7
 1VxdJ70PtWAKSk1ntkTBGdiDfVKc2TiPAYi2r94c2ntwuFBynrr95ImCSnJd59UMki0Wm1dxE2
 25yFdc4rLkuYcuN9GjNi51TCxqVI4WirKwo8eKhvslw8M9z+F6oOjQErb5faRkrhIVfv7BrREG
 HyKcQVfQuKDoSTchbK4ENkxYnP17X0aKXXo33b5iUpiIhpoGiKQQPEHB9B2ulAk8OoltY2VIE9
 Ppc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 20:08:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZYq6jvmz1SVp9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652929710; x=1655521711; bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJ
        SBsvKlJE=; b=Wz9R8/72j7o0/HjkO54/uNZ7vziwLqXBQOx2WZe1qEsSDBmqYAY
        oMOjpxPnGBnz+q+koTOKO3drn7FOj/jhxR0PTW1FJ7YLYdFtlYLeLGGN3yqvtwdr
        uts4LUP4ysOxN9iynlkWmhdkEs1tc1G3KNFA528x+jtAzYhfzX3F8jTjGnXp//sA
        rsE8C3oCVAzXP+CvDtHdo8BS4Oa1/JBePKnEcjfmBeFehBxoE9CWKq1Q/U6ExkMw
        hH5S6Kmi+EQY3sVzRRp11jv54IT+de7lJq7eYYN/WT35dSgh82O8SztxjP5NqAI5
        lf5E1L/acuF281Lj4heVeUrWlZG2K+SHppA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mMFO7Bu1U6lO for <linux-kernel@vger.kernel.org>;
        Wed, 18 May 2022 20:08:30 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZYm2BJDz1Rvlc;
        Wed, 18 May 2022 20:08:28 -0700 (PDT)
Message-ID: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
Date:   Thu, 19 May 2022 12:08:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 00:34, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>> I'm a little surprised about all this activity.
>>
>> I though the conclusion at LSF/MM was that for Linux itself there
>> is very little benefit in supporting this scheme.  It will massively
>> fragment the supported based of devices and applications, while only
>> having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

There was no real discussion about zone size constraint on the zone
storage BoF. Many discussions happened in the hallway track though.

-- 
Damien Le Moal
Western Digital Research
