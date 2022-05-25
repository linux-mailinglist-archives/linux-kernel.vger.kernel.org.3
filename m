Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD150533B63
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiEYLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiEYLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:11:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD345781
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653477097; x=1685013097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ApspzUBKpnPb41FxJK3phqUVQ+mxeo54ozF/QmwScU=;
  b=aunsX4am2VyTSGSgPI5scKu83WQ56WHALU/lz/0VaCsHzC2H2p6tyBTk
   egrp5Q7W8dChuyZsy0b7UPsae+IIxwGWkRGl/IdJD/hA9CmFR4x1x1oEC
   XCKvqRTYVI4+Mjg3UQh3tL9SMKjopPEGvtQ2JRyq2MAVsZrkz0h6q/fqc
   1EG02l+5zWQIRtjXNybaXt5JtAkjPI4nBagox+ybWjgxh7qc163qoggSo
   CmbGbYh+H+xrGCrLP8oEQijvuRV8ehy353/hqIuQHoZr222N6BE01F2MO
   j2UXa5EGZiFHeaL+l8+niuA5vGkBIPYGfiAV6cNgKddWEfDLkC9wvoJ/5
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="200173550"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 19:11:33 +0800
IronPort-SDR: TXKxW7QGWOoUZHR9a3dWL7Cae/LJ9kBDyTNkv3jHu1JvRrwuH8sFoLtrrmsHqHEm/b4K+5P9EI
 L4RSVnC/1fZXFKMNppyIYPW7lJ5JTgxhPmZxCXgSpw1XQer7WKwFV+X1dXFhO9n1JuIkK+N9OM
 jlsKndV31uXBuCoZ+7m75zyEmvbCWQ+YzMB8cgVKTtaURXn9rKJW+2kGeMbVPDtz88eL9Zb2is
 NICd8FmegP3cKIx211gyKuofcQ29E4JsKKnmdMH7LbVUevrT70G+606eVu/3+u1jgIsKDURqaD
 e2qsrPLxwLE4DYAbQMjHlXWB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 03:31:05 -0700
IronPort-SDR: Lfdt1Rety046e7dn0h5wDymP+d0pOhxG6929NLpi/WI3f1oqUT8Ws2IvGUTc1uGunT7PxnoAg8
 7FjpbWlsSBlw4i6ZxA+ZPvcI5gsrPaqQTwJKx/OK709a2FAmDXfEW0X/ikn6RXXxmm6HXytir+
 h1P35y9aQJk7R5/cm7Qy5sdnrtd3i5j2oebBVuZ3aNvU9skwW0Pfb9EaLsbfOWQ0ciNfDxfUF7
 TP13aGToy1Y5vJI7dBGOxaDDSf42+WHcktJkZFlvQK1CoFRALqE+RPtSnHLZp1hBfWqCrUzMTA
 r8w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 04:11:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7T0N6Q9zz1SVny
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:11:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653477092; x=1656069093; bh=1ApspzUBKpnPb41FxJK3phqUVQ+mxeo54oz
        F/QmwScU=; b=gimYfpIJP7lQ4yMAIpoZzyEWNEhMXnRdQibGB1an1gd6dWPOTXj
        iNvaHhqmQnGrd2kZ+0ikb9Azx+6NjehJfAqfUAJyfsEaA/AwQNhDLhFBQKWYPDHh
        aoI8M/p/E2Lv7W6D4oO+NC6mKLHZY6zabvT1g4MnExytLEsMmFbPMGnPLcDMLy4H
        oksHMJ4m0pq5ja2juHcWzzBeO3qDnOdnAO5ed8nDqCc26vVgubMfjZ/3k7SqedN4
        SKCrISvnEtihumQaXZ75C5AKw/KG1jQ/bxZQxLAM/wGsJIKWMoyPw12/ixPq7ZvP
        dSBfSl9QfoAQRTnhMzvijKIcKngks9M61BQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VoI8NlYGNMpO for <linux-kernel@vger.kernel.org>;
        Wed, 25 May 2022 04:11:32 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7T0M2BqLz1Rvlc;
        Wed, 25 May 2022 04:11:31 -0700 (PDT)
Message-ID: <48012e6e-f3c0-4436-5f5c-a2b0db89e33b@opensource.wdc.com>
Date:   Wed, 25 May 2022 20:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] ata: ahci: Rename module parameter for lpm policy
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220524170508.563-1-mario.limonciello@amd.com>
 <20220524170508.563-3-mario.limonciello@amd.com>
 <Yo3w/dsaly+gcQNR@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yo3w/dsaly+gcQNR@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 18:03, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 12:05:07PM -0500, Mario Limonciello wrote:
>> The LPM policy is applied to more chipsets than just mobile designs.
>> Update the module parameter to drop the word "mobile" to make this
>> clearer to users.
>>
>> Also, document this renamed parameter in the admin-guide for users
>> as it was missing previously.
> 
> Even if the name is confusing I don't think we should rename it as
> that breaks existing setups.  I think just updating the documentation
> is good enough, but if you feel strongly we can just add the new name
> while keeping the old one as an alias.

+1 for the alias.

The other thing that this series need is to add the changes of the LPM
policy initialization according to the adapter capabilities (your patch
and the patches from Runa) as well as accounting for the eventual nolpm
link horkage flag. Otherwise, I fear that this change will generate many
regressions.

-- 
Damien Le Moal
Western Digital Research
