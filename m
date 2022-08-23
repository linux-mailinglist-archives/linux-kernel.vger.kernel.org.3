Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054DB59E431
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiHWNTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiHWNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:19:32 -0400
Received: from out29-76.mail.aliyun.com (out29-76.mail.aliyun.com [115.124.29.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC08053F;
        Tue, 23 Aug 2022 03:18:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436883|-1;BR=01201311R841S44rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0147595-0.000491414-0.984749;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.OzvLOEv_1661249816;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.OzvLOEv_1661249816)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 18:16:59 +0800
Message-ID: <6412c518-426a-69a4-e419-83dc97bebe27@allwinnertech.com>
Date:   Tue, 23 Aug 2022 18:16:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] scsi: core: Fix block I/O error of USB card reader during
 resume
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220817083438.118293-1-michael@allwinnertech.com>
 <ceba3c96-5f32-9b5a-bacc-0eb942b9b90b@acm.org>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <ceba3c96-5f32-9b5a-bacc-0eb942b9b90b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/2022 9:52 PM, Bart Van Assche wrote:
> On 8/17/22 01:34, Michael Wu wrote:
>> When accessing storage device via an USB card reader, a block I/O error
>> occurs during resume:
>>
>> PM: suspend exit
>> sd 0: 0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte
>> =0x08
>> sd 0: 0:0:0: [sda] tag#0 Sense Key : 0x6 [current]
>> sd 0: 0:0:0: [sda] tag#0 ASC=0x28 ASCQ=0x0
>> sd 0: 0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 17 ce e1 00 00 f0 00
>> blk_update_request: I/O error, dev sda, sector 1560289 op 0x0:(READ) 
>> flags
>> 0x84700 phys_seg 19 prio class 0
>> sd 0: 0:0:0: [sda] tag#0 device offline or changed
>>
>> Fix it by changing the action in scsi_io_completion_action() from
>> ACTION_FAIL to ACTION_RETRY by adding the condition `cmd->device->
>> lockable`.
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/scsi/scsi_lib.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 4dbd29ab1dcc..4bc480721947 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -704,7 +704,8 @@ static void scsi_io_completion_action(struct 
>> scsi_cmnd *cmd, int result)
>>       } else if (sense_valid && sense_current) {
>>           switch (sshdr.sense_key) {
>>           case UNIT_ATTENTION:
>> -            if (cmd->device->removable) {
>> +            if (cmd->device->removable &&
>> +                cmd->device->lockable) {
>>                   /* Detected disc change.  Set a bit
>>                    * and quietly refuse further access.
>>                    */
> 
> To me the above doesn't look like a good way to address this. I don't 
> see why a device being lockable should control whether or not a unit 
> attention results in a retry? Shouldn't the decision taken by 
> scsi_io_completion_action() depend on the ASC and ASCQ codes rather than 
> on whether a device is removable and/or lockable?
> 
Dear Bart,
Yes... My patch did seem suspicious. Here's the scene about the block 
I/O error: Some card reader does not respond the command 'MEDIUM REMOVAL 
PREVENT' correctly, as a result, the host does not send subsequent cmd 
'MEDIUM REMOVAL ALLOW'/'MEDIUM REMOVAL PREVENT' before/after sleep, 
which leads to a enumeration failure after system resume.
I wonder, without changing the behavior of the device, is there's a 
better way to solve this? -- Modifying the scsi core should not be a 
good idea though :(

> BTW, the code modified by the above patch is old. This is what I found 
> in the 2002 version of scsi_lib.c:
> 
> if ((SCpnt->sense_buffer[0] & 0x7f) == 0x70
>      && (SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
>          if (SCpnt->device->removable) {
>                  /* detected disc change.  set a bit and quietly refuse
>                   * further access.
>                   */
>                  SCpnt->device->changed = 1;
>                  SCpnt = scsi_end_request(SCpnt, 0, this_count);
>                  return;
>          } else {
>                  /*
>                   * Must have been a power glitch, or a
>                   * bus reset.  Could not have been a
>                   * media change, so we just retry the
>                   * request and see what happens.
>                   */
>                  scsi_queue_next_request(q, SCpnt);
>                  return;
> }
> 
> Bart.
> 
> Thanks,
Thanks for your kindly notice. I looked around in the latest linux 
mainline repo, but could not find this code. Where can I get this 2002 
version of scsi_lib.c? Thank you.

-- 
Regards,
Michael Wu
