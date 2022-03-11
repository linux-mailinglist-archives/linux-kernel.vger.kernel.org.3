Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195F4D6229
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiCKNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiCKNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:13:23 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 05:12:19 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FA1C2DBD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:12:19 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220311131114a52a99d5f1e7f792db
        for <linux-kernel@vger.kernel.org>;
        Fri, 11 Mar 2022 14:11:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=raphael.lisicki@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OiZ+D1JjDvqox07n28ij4jAYs8XPUSnRKqPqymKI+aA=;
 b=bqWAFRG3IjGuc77kwk+aecHcPU/G5lXMbJx+PcLLYxdixFUNNYh8u+RU7kObh1jj9LHOQz
 XbwnG7/mZKPv5eNMDZI0kM45vGbDApN5XbO0/6oonAa29untph4bJRCahjyDqYIt0rBb98rp
 XK4G9GvGmop/G/AmdAXYlYApnIb58=;
Message-ID: <f7ca02c3-c632-7141-02f6-4b2055621e34@siemens.com>
Date:   Fri, 11 Mar 2022 14:11:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] scsi: hpsa: prevent hpsa to severly delay boot
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, don.brace@microchip.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        storagedev@microchip.com
References: <20220204131247.1684875-1-clabbe@baylibre.com>
From:   Raphael Lisicki <raphael.lisicki@siemens.com>
In-Reply-To: <20220204131247.1684875-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.02.22 14:12, Corentin Labbe wrote:
> On my HPE Proliant microserver gen 10+, modprobing hpsa lead to:
> hpsa 0000:01:00.7: unrecognized board ID: 0x00e41590
> hpsa 0000:01:00.7: unrecognized board ID: 0x00e41590
> hpsa 0000:01:00.7: can't disable ASPM; OS doesnt't have ASPM control
> hpsa 0000:01:00.7: board not ready, timed ou >
> And the boot is severly delayed until the timeout.

The same happens with ProLiant DL360 Gen10.


> 
> The controller is HPE Smart Array S100i SR Gen10
> 
> I have tried to add (naivly) to struct board_type products:
> 	{0x00e41590, "Smart Array S100i SR Gen10", &SA5_access},
> but the board still time out.
> 
> With further search, I found that the S100i seems to be a fake SW RAID controller usefull for windows only.
> 
> So I use the following patch to fix the boot stuck.


Also confirmed on ProLiant DL360 Gen10 as working, but not sure about 
the general approach.
