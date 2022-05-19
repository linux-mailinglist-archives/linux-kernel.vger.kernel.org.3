Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1552CA35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiESDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiESDT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:19:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4A3A72B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652930366; x=1684466366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SUCPImugSk=;
  b=Pl48gXhoEMl30d9lBZ5u1uysJp6ioYA/1IQ8dFbso+Z0SgS4hi6kUmGm
   gYJeiKR/ZMd2SLL+C0tJ6s/SEuGmC2w/JMrDbV6qTGlvTuKRf04wllk7C
   n4MzbnUlmYzd4p59uGNP1EFIZmrJRe/cgQ+9+uA4yn04VmDzCH0Z/qUUh
   7PDmUa9+mkU3RngxEtwauTnTbIx+5vVvIa55ZJ6DQMQKb5ZAvdRd4oYUj
   kPnvcXYU0KY84a/pQeC23hcVwFdDG2f7GDctsK2pJzQDlZKvd6jKYhMRm
   PFIq2mt1snYCnhegRkaIJ9MmYCKWfUMbrlIkI5sF2nVwtXwnJWqzeyuGE
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="312724360"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:19:24 +0800
IronPort-SDR: JgQrCOstfryy4jo1NB8eoYYpvNRd1V/MAxErGQAaZbk4a2fl652K4uc83CGJO2PcoMqkw40J/B
 SF7OmwndIuTsU5AoeUIMOKgPBEEVCPNaSIDzC7cELHoWfVJQAK3wwM6rHoOiWsJp7TvN0Icz5I
 6F9i1qXA8OgnyPF2OKH0eajFIGw1I4QBjliWnPlEBx6auTkxNdbStKTdwC7Hc9aqRGXEeJ1leW
 HCpEBVJn1+jlnwX6MBcpR+NHGT6zSKcAgKDpNkrIbKibW0nRKw52VJGSiH6XfS6bmA4Bquq7/n
 37nx+rVGnBL9WksnlfSFWYZP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 19:44:55 -0700
IronPort-SDR: 6VU663b+Fp1YdkjLWhZ1YkUAfv/R+Y7cO3DZwl8q5Ix9EtA0w21OCuF95t8VFfEKb2LFHqwULO
 UyENMohrxTfsR6NWr7CH81lEic+1jBlmJX5Le+WQcGRIfO0+sVdfDecliVHV1YduNotwJGv4yu
 MKHKW/FTVr/LBr0CuDgAbXuLtt0u5UQIDSUYNF1NqV1McFqhF+NnDQeJM45KHtRswqwVfiCePj
 FPwBb/cwah+3/0GuIb/GKCCEXmBkAfl52Gc+k4YQmgLdT5e+qR9qqoRbini54waruqtaZF6+Nf
 9MY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 20:19:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZpM5GCQz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:19:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652930362; x=1655522363; bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SU
        CPImugSk=; b=nzaWEP3sKrJcNJ3FPCURQIKIvl67f8jA/2wm/ii3lwBWbn3WDZi
        IE/sOdtD7+ND9OHmBJ3aUEGU0W+1DpoA2XmrAamVj/mQ0HVTFq1EL8uyncO3DMS+
        J6dNpyjlz4DKmYidGmO8sIfPQfmUBBnQpWUjWhL8w9LCRAZR9TmFfAodNv2Kwouw
        wDtjAfO6lQ1N7Nuceziw58wMV3A4b6DnW+N3QWimfF9u6RsX5pftmjiOUJ84QuPu
        NIbYasgAX+/cJ6wQy20ztixoasu2bW+bMu0rTHXYzniKQom03aoiKFnWeujXub7H
        jv0tF2/umdPgH5kXJ8hmdql6xR52NXpLPmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eqnjWpDnk_5p for <linux-kernel@vger.kernel.org>;
        Wed, 18 May 2022 20:19:22 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZpJ0qRQz1Rvlc;
        Wed, 18 May 2022 20:19:19 -0700 (PDT)
Message-ID: <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
Date:   Thu, 19 May 2022 12:19:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220519031237.sw45lvzrydrm7fpb@garbanzo>
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

On 5/19/22 12:12, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>> I'm a little surprised about all this activity.
>>>>
>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>> is very little benefit in supporting this scheme.  It will massively
>>>> fragment the supported based of devices and applications, while only
>>>> having the benefit of supporting some Samsung legacy devices.
>>>
>>> FWIW,
>>>
>>> That wasn't my impression from that LSF/MM session, but once the
>>> videos become available, folks can decide for themselves.
>>
>> There was no real discussion about zone size constraint on the zone
>> storage BoF. Many discussions happened in the hallway track though.
> 
> Right so no direct clear blockers mentioned at all during the BoF.

Nor any clear OK.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research
