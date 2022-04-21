Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC750976B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384784AbiDUGXs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 02:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDUGXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:23:43 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 23:20:54 PDT
Received: from mx2.uni-regensburg.de (mx2.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8E13DE1;
        Wed, 20 Apr 2022 23:20:54 -0700 (PDT)
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 1B71E600004D;
        Thu, 21 Apr 2022 08:11:05 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id 0528B600004E;
        Thu, 21 Apr 2022 08:11:05 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 21 Apr 2022 08:11:05 +0200
Message-Id: <6260F577020000A1000497D1@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.0 
Date:   Thu, 21 Apr 2022 08:11:03 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "open-iscsi" <open-iscsi@googlegroups.com>,
        <haowenchao@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, "Chris Leech" <cleech@redhat.com>,
        "Lee Duncan" <lduncan@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Cc:     <linfeilong@huawei.com>
Subject: Antw: [EXT] Re: [PATCH v2] scsi: iscsi: Fix multiple iscsi
 session unbind event sent to userspace
References: <20220418000627.474784-1-haowenchao@huawei.com>
 <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>
In-Reply-To: <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Mike Christie <michael.christie@oracle.com> schrieb am 20.04.2022 um 18:28 in
Nachricht <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>:

...
> 
>> diff --git a/include/scsi/scsi_transport_iscsi.h 
> b/include/scsi/scsi_transport_iscsi.h
>> index 9acb8422f680..877632c25e56 100644
>> --- a/include/scsi/scsi_transport_iscsi.h
>> +++ b/include/scsi/scsi_transport_iscsi.h
>> @@ -256,6 +256,7 @@ struct iscsi_cls_session {
>>  	struct workqueue_struct *workq;
>>  
>>  	unsigned int target_id;
>> +	int target_unbound;   /* make sure unbind session only once */
> 
> 
> We don't need the comment since the code using this is so simple
> and the name of the variable tells us what it's for.

Actually I think a comment may be worth it, but it should say what the variable expresses, not what it is used for
(the use may change, but hopefully not the semantics (unless updated globally)).
So maybe: /* is target unbound? */
(the question mnark emphasizing that it is a boolean type of variable)
But still, if the name is mostly identical to the comment, one may leave out the comment.

Regards,
Ulrich

> 
> 
>>  	bool ida_used;
>>  
>>  	/*
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
> "open-iscsi" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
> email to open-iscsi+unsubscribe@googlegroups.com.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/open-iscsi/938bca13-2dcc-24c0-51b5-26f7e723 
> 8776%40oracle.com.




