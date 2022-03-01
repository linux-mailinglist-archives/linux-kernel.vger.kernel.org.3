Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4F4C8D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiCAOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiCAOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:20:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293590CFF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646144404; x=1677680404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vBaQ0UbZhx8vNzME+2c2QEiwGyK34ZDpHbyzSowRbV0=;
  b=YHk6jLSssl1xvOSrQSoOOqDZ/gvDKNUcXwMjKMPLKwDuScXefPjr7pDO
   z0W0VLfOvjfgjiC2sOiALF/1ukAXVEVYPv3z3Jreepyp/No5cQ1oT1MO/
   cJBI4vbMmKw9Lxll9a677tiv41L4r3Hs2kG8EYyi9UrXFUkxqWR6lJY3k
   qVR9fZ/O6TmfIFbe4JhfFLDMj6p3GidlK10L92CsCxmo29iKa0kHSmhab
   Bmk/XkcqjAfy+HwAxUlzJZELFMAFnA2iJUsyyv7Hvw7Pzf91geTwIrjzI
   kqfR0TX37l0Eiu7/8u8qb9SNTvMb78wgx1k5/EC2++5z2Q9dX6eNdC9R+
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="193127485"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 22:20:04 +0800
IronPort-SDR: vtxqnnFp2UY+PYj3pOYpFAjx2gdse03HiIE8/UlZWzcQuZQszyqDwopx+er3+2VWARKmHFtVKJ
 /be6ssNYqp0RRh/OnUZIfIRJwAIm90HtEEJXO7f4WG+ncgJQt3skFLTNqkg4/7utvP3EZltc+8
 VX0BVpJBEXmNfVIQ357yaYswa+7E7ka59tV9kfGgRXvMqRmsB/aHHTytBtyzJ0cg3CfBK2w1gi
 1G0sTOAkm7is1cWmmMMklc59KjlQiY2GCW8jqABuuDU9GdWWoygl3AWkMACYkcrigeFmys4RgV
 HgPg+i+jADPRHOCOz67ouPn3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:51:28 -0800
IronPort-SDR: 5sFiFTi6EjVih8E6y+YdTKTMZQbdJ5Ae5gg5XIiPBXB6RQIJ5LpYa7lWZdIOc+1Q/bedHl1twa
 a97jwXh+k+8Cp2SmVAmHWB+RT9UwQ97UkV1h9LDTbgNd+hmWbYgw/TjXkzl1tOLzwOH+BF8KVT
 6DIFmnvrdQ1MZz/iPvu83Lmt4NjHDfttlgyRno6YgY+seYx6PbbKqlA26l0ES1b0RXt98ntBlR
 vTEWx9nqZToB8o7TkWR/cvDrgNYcxSNI9d2AACTvvtuTZ2DQ4xH/2j1QHsIhtxa5r8PVsSocAB
 k/Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:20:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7KC81psnz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:20:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646144403; x=1648736404; bh=vBaQ0UbZhx8vNzME+2c2QEiwGyK34ZDpHby
        zSowRbV0=; b=n92MS5wgF+d40BAo5D004O2+WhAqtdS1LozudLHeN5RbhyAJwS4
        kQtww3cGhEqZq/vts4Q4/3lsGTQC0bPH/yKMa29J+xXA4nsOUEnZhTgyppjS7eUw
        QYpn48UP0iC0u17961zuLKn9UmeTnvASUyoidZZ0pSvTv734B0yKylX6XpJ02/3D
        ev60HPqDXznF+wm9GeZfN165o81q4XWO+bPw0PqQ77TMCBrO99gdq+FwpiAMBEOd
        aBwlt3/n8uIWLSRQf0eeI3esvl4DZ/+jjCIgPzh4Qt23+4oEqutImiz1Yz2SHKch
        Tgo2nZFju3tXhL5o5f4tHkWFW7Rb3hsrpCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MSwAqw3ahjDK for <linux-kernel@vger.kernel.org>;
        Tue,  1 Mar 2022 06:20:03 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7KC639nHz1Rvlx;
        Tue,  1 Mar 2022 06:20:02 -0800 (PST)
Message-ID: <9ad7ffe0-90ed-d54e-3a20-8ab52886f4a6@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 16:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] ata: ahci: Drop low power policy board type
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <Yh3WdvBYRTdXkyuk@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yh3WdvBYRTdXkyuk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/01 10:16, Christoph Hellwig wrote:
> I really like this and hope it can stick.  Needing quirk lists for
> sensible power policies is a bad thing.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

I also think it makes sense. However, since we are already at rc6, I am going to
wait for the 5.18 cycle to apply this early on in rc1 so that we get plenty of
testing time and have time to revert if needed.


-- 
Damien Le Moal
Western Digital Research
