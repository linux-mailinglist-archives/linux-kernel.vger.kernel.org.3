Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109F257BACA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiGTPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGTPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:51:13 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 08:51:12 PDT
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AA4B490
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:51:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 34132412D2;
        Wed, 20 Jul 2022 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received
        :received; s=mta-01; t=1658331699; x=1660146100; bh=BiGYJAeCpEGQ
        em6DfQ73uEeCnzcf59XOM101tD6+ZC0=; b=l8yWjs2Yw6IK9hmOTT3aBz66aso7
        XGGVXSVZMNubkjUgQgs6tWOoLDHRrvMjTh7e29NXxO5t0sXCkZfjK0xa3O63aO1D
        W6M+3hmLmMJjfKJKSj0tip79xpyZvmCNG+tOZxfFzfNuW+rZVi1/eDWI2In/WaH2
        VNyY1WSnHnmsRdY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kvp7q4TTa0Zl; Wed, 20 Jul 2022 18:41:39 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C6508412CD;
        Wed, 20 Jul 2022 18:41:35 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 20 Jul 2022 18:41:12 +0300
Received: from yadro.com (10.178.118.226) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 20 Jul
 2022 18:41:11 +0300
Date:   Wed, 20 Jul 2022 18:41:10 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Mike Christie <michael.christie@oracle.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Youn <John.Youn@synopsys.com>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] target: Implement TMR_ABORT_TASK_SET
Message-ID: <YtggwBMKgIJqN4mT@yadro.com>
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
 <7d31722a7e07bc24ea37b5841a17545003eeddb4.1658195608.git.Thinh.Nguyen@synopsys.com>
 <74bf1df3-a466-9d78-1a25-7425c89b9fa3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74bf1df3-a466-9d78-1a25-7425c89b9fa3@oracle.com>
X-Originating-IP: [10.178.118.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:56:07AM -0500, Mike Christie wrote:
> «Внимание! Данное письмо от внешнего адресата!»
> 
> On 7/18/22 9:07 PM, Thinh Nguyen wrote:
> > Task ABORT TASK SET function is required by SCSI transport protocol
> 
> What OS is using this and how do they use it? For the latter, does the
> OS try an abort for each cmd first, then try an abort task set if the
> aborts fail (does fail mean get a response that indicates failure and
> also does a timeout count)? Or does it start with the abort task set?

AIX IIRC. However, this feature also requires valid bits in one of the
VPD pages.
