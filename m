Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8584F221E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiDEEh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiDEEhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:37:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2846D6C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649133286; x=1680669286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vaxdEvOIKTPP9ACiHd6DRhWXVl5w76xkSLjz1eIi0NU=;
  b=P4Zfi/S4FlBv788yihq+c/qEX53NY77ZGpMqW756yCt4cPfNUzzAJOBY
   qVWMsARL+Z+SRi/RiqOnTDwQd45ldOGMs1Nz9yU+SteOcuO5MMOzryoyu
   Kyb0o4WKvjnzoH1e/RFNOGzwD2fONmkWTEV4Kg9+sywjJeHYGeRCdChTw
   3VmaFnHJCrkTNQcJbS11EzIbYaeON7Gc1uSlLCDznsx2q3sNu04jJjTWF
   w8/yhru0QnGvmUZM12+y8Naa4n5apkH6Nk9aYOu72/uYv8cXVFfgCYE21
   cl4BteiH4rIajWbF9/1u1u/KMyK9hC4lb3rrlslVOwj2fn4kA7+FenVAk
   A==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="309062976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 12:34:44 +0800
IronPort-SDR: qNIS6+I3xcYexaz2Xj4G/JoQbbF/oOYvkuRZrhPnOZQP8+TfFfX+BgqBL8exfxA8Y5VAmi5KS7
 6WvFIUondyZs31CRkyShy6lvYhlYgmqJzo+xJfJPX267nrVqM9DYulM/3zmlkyTN1lVMISovIg
 WWQlC/+7ZE2coKtyE6QsFEC3YP9tnvVLV247o4mqOV2qnl94ugQD26raJ8NbRVurZGpY4pCfIX
 UkwfJEQ6RRD/WZU+6hqgRRFAOOX0Icnq0oSUEMVu56PduG1BfU2xMlJ498WxnEDjyF11MG4t9u
 f065tmpuHi+T4fCVOHFW5lBx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 21:05:28 -0700
IronPort-SDR: WJe9HvLRuq8bDMtcFHue5ofNVkF5uYlYEoiXZf0QS5R7gVzp2uDp17e1ZfWxQuv5lR86mXrdRg
 POVHwxfsMa3Nmz9CXyr51AVgVIVZg/HDs2OtvhssEPwL5cYxvBGvuTEsVMczXW1j5kimD+eFFd
 h8S395GuK1eQ/kD+4EtVMYNgmh1ZcaeM+OI0wTECIvxsUQtjNZxZBbb+w5N0Jpw3CKPuTl0Ceg
 XbtnhIrFCAlu7+ueb4zzDUIf0Jd3iGInt9mMJOLszOfrUaKJw3TPVu6nQFrr6rsVzZEAiU1Zcz
 NQw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 21:34:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXZYc3VC3z1SVp0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:34:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649133283; x=1651725284; bh=vaxdEvOIKTPP9ACiHd6DRhWXVl5w76xkSLj
        z1eIi0NU=; b=PpVNb133lJQ9lLmbH8WCbuzDy8iC3/0GfkXemwMTx0kgdX9TR81
        WK+h7IAHWWmYZMGqpRkkI4HkWPo882KnBBQ/9/YJ+854Wix64D7Q/Ux82VKxtQOd
        kPLPYMeChhOvpCPnaNzsdTseuzrPHkVsrfBX1DJYbhQSkKdqfgKMLSz0FZVfUQZW
        /K5MoY+sJLdPga5NzTTp2MqGJzyQfqKu1rmE22MGxzwf6FCOZTMsB8YjiIncV6+n
        Hl0bfYUqT6ZRTl0/zON+bKxWT4m2avtQSG5uUlplwRRAX2WTq7Wvnjc2ZM4wF1Bp
        wGy72RQOVWCxEGYUPUC4phh3lgHQUPV4PyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nAWdZ_M9QH4X for <linux-kernel@vger.kernel.org>;
        Mon,  4 Apr 2022 21:34:43 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXZYb0VB2z1Rvlx;
        Mon,  4 Apr 2022 21:34:42 -0700 (PDT)
Message-ID: <a0598c8f-692a-fcb8-9553-32f6947a8fc3@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 13:34:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
 <YkvGp7c8QLf5i/j0@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YkvGp7c8QLf5i/j0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 13:33, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 03:02:02PM -0500, Mario Limonciello wrote:
>> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to CONFIG_SATA_LPM_POLICY in
>> commit 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
>> configuration item").
>>
>> This caused some pain as users would invisibly lose configuration policy
>> defaults when they built the new kernel.  To help alleviate that, switch
>> back to the old name (even if it's wrong).
> 
> Note that for this to be useful it would have to go into 5.18.

Yep, that's the plan. I will send it for rc2.

-- 
Damien Le Moal
Western Digital Research
