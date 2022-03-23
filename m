Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391E4E4C70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbiCWFym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCWFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:54:37 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67C63E4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648014787; x=1679550787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=au+ERu5m71YdsbRYnHasfquEzLmwfMRgnitjNITmxA0=;
  b=Tft/bF3T+8pv2mtw5MSW5QFHKDDt4ZwcXgSqUK0KJIt0GUIB+G/O4enL
   mIEx3x/aLCUqj9aPo2cX4HON2QtrXb8wFG1et4iQmYlXbrtJDWGawxf1Z
   wEWw+NTUvNaN33u88f3PcgmuEBnY/y0qXqwRjoWASwKUzHOQMDgYT5D40
   Fg3Oapc+HvRra3knf8HWNh9rPppcjLXMtDgUJRTN+JBEGbbZcNe6PKJ4u
   OoOJXYllklWDe9vAL4xi6RTkJdCpjKKTBZPvx0hlwX3ag68EANtP3I89g
   sqNaRJgTf8REk+GzutwHnLj4o7U/0/LJ2IvodQQGVclMNQenIkNAui8PN
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196959245"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 13:53:04 +0800
IronPort-SDR: LXVpcfmf1juLJUsu7gLSGH8fvA8a/WPnVl1kcqNLl4zpMElA8g6LOpNm6okT9vfRaimtnZhYCm
 zYih9oAmIowElV59WBwnwTpxUivB6ScGTd4qGIgHmzXVQLCjxMp1nN3oLophUCmi8cMq66mRjH
 lCnJ09TKUDTH6uAA59JTKleg5sVIjRTNSnZRJ5+LztreuroVH4YlD+Kl0BP+DNxsDsbT62Ky1b
 sFI32F2fMXvDXK8jOZ74H6mLhJPOfFb2v42CmosAeAJ2c0I9da3SNTsu+FNh2qCvIR1eh/YNC0
 V+mMaolrXcAxLg2C0hGnMGZs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:24:03 -0700
IronPort-SDR: LHLydiOxujq1WYl3yYa/NHkN+/Ey+xyPJytjjhOkVb63z7TwsGatSa4TF8QWfaxeH5sDMJyRg3
 Q/nV2OY2C4v41dpVcu0mt2X1oIsBs1vEtz1MnwDMjXX0wEKgwJjk1W90TYpMmUH3WoBhRFubfN
 T6uuh9oLTWLlkQDGv8qiFxuZMKzzAM5Nx6h5m/opt5itZ/TLeHb/IUL9OjrTdIITpo3BXvmZgc
 kqS06q91UFF1NyjLM9qjF5imE2KhPWTaK3ZcEABzq179o4d5CfiRiyYL4+Nz5YvIloZVGK9fVv
 KLI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:53:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNcw01Rwfz1SVp1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:53:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648014783; x=1650606784; bh=au+ERu5m71YdsbRYnHasfquEzLmwfMRgnit
        jNITmxA0=; b=JCBIFcgwa1MJo9AT1hflh74B91Mi3mhzRr5qYjL18XOucycSN8A
        OXdxy5+17Q4H31Fr7m+avEEaBWloL1cIxPuLS5P31deOAzYaBO3/rzvKStBQg1oF
        VQfeBV1QAKLdDjWGk4c3ydhGCwl72OwFaxSBP7FUJ/jBmUrZeiQ6roJGgEbNhheU
        J2ILYmbCZDGl6/+MIlex8gQxpnCX1vFbNaj4o4AEp2q3OTf7wEhxxnqUpd2CpXm4
        3WYr2lism7MtoJw0Wm+ftS9wl8WwcqUDA6JdJ+OoVPxnryxLpAAkBDN/6dAR48gE
        2yYZA9pw1wqSPSf3d4Gb/Hc1WFwDtbPoqxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EILUoS-7fSEo for <linux-kernel@vger.kernel.org>;
        Tue, 22 Mar 2022 22:53:03 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNcvz1Qd8z1Rvlx;
        Tue, 22 Mar 2022 22:53:03 -0700 (PDT)
Message-ID: <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 14:53:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
 <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
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

On 3/23/22 14:52, Diego Viola wrote:
> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/23/22 14:40, Diego Viola wrote:
>>> Use the contraction "it's" instead of the possessive form "its".
>>
>> Well, while at it, let's use proper formal written English, so:
>> s/it's/it is
>> s/isn't/is not
> 
> Fine with me, do you want me to send you another patch with those changes?

Yes please.

> 
> Regards,
> Diego


-- 
Damien Le Moal
Western Digital Research
