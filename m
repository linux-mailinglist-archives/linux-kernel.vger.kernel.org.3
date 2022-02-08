Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124494ADC9B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376875AbiBHP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiBHP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:27:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369AC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:27:35 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218EXKc4024574;
        Tue, 8 Feb 2022 15:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p12du2hDwvetB0fMT94MAlGny81UMquYUwY3x3iLJQU=;
 b=rhNviVZBGXNE/l0+eAKLRPy2bxiGL5ZOqwOd0PJqEkuBjWcxqb1ADte6qn8Z9E870IA/
 WFe1M8YF0++0jzlOQck7SCxpmXNk6lKZTnQ6KafjokzP5MfDDPBjlGaHDNvGQlq5vVFt
 +M9f4nkoyyG9oSxvSKNTU59KhYRKKgvoe4kIsARuxZ4NCHB5iFfxz554TyImNKve9PJc
 kz09nGd37w24MMIwjZTgTxXNyFUtoGFtbEPlERuVtOLrg0qACkoCOrA4a8Xtv4TA0DOL
 BeEElqS8c56OSC3ZZY2QPdQZKZLX8kWih6pJnjvAcsgJ+nB1XEsgelmQBPkqephh9MdW hA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3npsgpsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:27:26 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218FKTRB017692;
        Tue, 8 Feb 2022 15:27:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3e3gpyd3up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 15:27:25 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218FROa628705272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 15:27:24 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C486124064;
        Tue,  8 Feb 2022 15:27:24 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B616C12405B;
        Tue,  8 Feb 2022 15:27:22 +0000 (GMT)
Received: from [9.163.31.52] (unknown [9.163.31.52])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 15:27:22 +0000 (GMT)
Message-ID: <8cedee1b-c380-b13e-1769-df8778a70ff0@linux.ibm.com>
Date:   Tue, 8 Feb 2022 09:27:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fsi: occ: Improve response status checking
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
References: <20220110155827.13976-1-eajames@linux.ibm.com>
 <CACPK8XdgOYTwy5aOQgSuSJaQUjxnobN2c3ph=dkAcWYJDVbN+w@mail.gmail.com>
 <3897c432-4365-7c54-b336-7331bb328350@linux.ibm.com>
 <CACPK8XcoJ2O=0RYZy0R=9xHCRne4F4f_3Q1hQYCAmiypepz7yw@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8XcoJ2O=0RYZy0R=9xHCRne4F4f_3Q1hQYCAmiypepz7yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gQQ0_KFFsySE6AsrxtkVXSINHYeUFihj
X-Proofpoint-GUID: gQQ0_KFFsySE6AsrxtkVXSINHYeUFihj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/7/22 03:56, Joel Stanley wrote:
> On Mon, 31 Jan 2022 at 15:29, Eddie James <eajames@linux.ibm.com> wrote:
>>
>> On 1/30/22 23:56, Joel Stanley wrote:
>>> On Mon, 10 Jan 2022 at 15:58, Eddie James <eajames@linux.ibm.com> wrote:
>>>> If the driver sequence number coincidentally equals the previous
>>>> command response sequence number, the driver may proceed with
>>>> fetching the entire buffer before the OCC has processed the current
>>>> command. To be sure the correct response is obtained, check the
>>>> command type and also retry if any of the response parameters have
>>>> changed when the rest of the buffer is fetched.
>>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>>    drivers/fsi/fsi-occ.c | 63 ++++++++++++++++++++++++++++++-------------
>>>>    1 file changed, 44 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>>>> index 7eaab1be0aa4..67569282dd69 100644
>>>> --- a/drivers/fsi/fsi-occ.c
>>>> +++ b/drivers/fsi/fsi-occ.c
>>>> @@ -451,6 +451,15 @@ static int occ_trigger_attn(struct occ *occ)
>>>>           return rc;
>>>>    }
>>>>
>>>> +static void fsi_occ_print_timeout(struct occ *occ, struct occ_response *resp,
>>>> +                                 u8 seq_no, u8 cmd_type)
>>>> +{
>>>> +       dev_err(occ->dev,
>>>> +               "resp timeout status=%02x seq=%d cmd=%d, our seq=%d cmd=%d\n",
>>>> +               resp->return_status, resp->seq_no, resp->cmd_type, seq_no,
>>>> +               cmd_type);
>>>> +}
>>>> +
>>>>    int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>>>                      void *response, size_t *resp_len)
>>>>    {
>>>> @@ -461,12 +470,14 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>>>           struct occ_response *resp = response;
>>>>           size_t user_resp_len = *resp_len;
>>>>           u8 seq_no;
>>>> +       u8 cmd_type;
>>>>           u16 checksum = 0;
>>>>           u16 resp_data_length;
>>>>           const u8 *byte_request = (const u8 *)request;
>>>> -       unsigned long start;
>>>> +       unsigned long end;
>>>>           int rc;
>>>>           size_t i;
>>>> +       bool retried = false;
>>>>
>>>>           *resp_len = 0;
>>>>
>>>> @@ -478,6 +489,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>>>                   return -EINVAL;
>>>>           }
>>>>
>>>> +       cmd_type = byte_request[1];
>>>> +
>>>>           /* Checksum the request, ignoring first byte (sequence number). */
>>>>           for (i = 1; i < req_len - 2; ++i)
>>>>                   checksum += byte_request[i];
>>>> @@ -509,30 +522,30 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>>>           if (rc)
>>>>                   goto done;
>>>>
>>>> -       /* Read occ response header */
>>>> -       start = jiffies;
>>>> +retry:
>>>> +       end = jiffies + timeout;
>>>>           do {
>>>> +               /* Read occ response header */
>>>>                   rc = occ_getsram(occ, 0, resp, 8);
>>>>                   if (rc)
>>>>                           goto done;
>>>>
>>>>                   if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>>>>                       resp->return_status == OCC_RESP_CRIT_INIT ||
>>>> -                   resp->seq_no != seq_no) {
>>>> -                       rc = -ETIMEDOUT;
>>>> -
>>>> -                       if (time_after(jiffies, start + timeout)) {
>>>> -                               dev_err(occ->dev, "resp timeout status=%02x "
>>>> -                                       "resp seq_no=%d our seq_no=%d\n",
>>>> -                                       resp->return_status, resp->seq_no,
>>>> -                                       seq_no);
>>>> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
>>> You're testing for two different types of conditions. The first is
>>> when the SBE is busy doing something else:
>>>
>>>                   if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>>>                        resp->return_status == OCC_RESP_CRIT_INIT ||
>>>
>>> And the others are when the message is not for the current user:
>>>
>>>                         resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
>>>
>>> Should we be separating them out? It makes sense that the first means
>>> we should keep trying. For the second case should we bail straight
>>> away, instead of waiting for the timeout?
>>
>> They're really the same thing actually. If the sequence number or
>> command type is incorrect, it means the OCC is processing a different
>> command, and we need to wait for it to get to our command.
> And we sometimes see one but not the other (ie, the return_status
> doesn't cover all cases)?


Yes, we definitely can see each one without the others, so we have to 
check for them all.


>
>>
>>> How often do we see one vs the other?
>>>
>>>> +                       if (time_after(jiffies, end)) {
>>>> +                               fsi_occ_print_timeout(occ, resp, seq_no,
>>>> +                                                     cmd_type);
>>>> +                               rc = -ETIMEDOUT;
>>>>                                   goto done;
>>>>                           }
>>>>
>>>>                           set_current_state(TASK_UNINTERRUPTIBLE);
>>>>                           schedule_timeout(wait_time);
>>>> +               } else {
>>>> +                       break;
>>>>                   }
>>>> -       } while (rc);
>>>> +       } while (true);
>>> Use while (true) instead of do { } while (true) to make it clearer
>>> what's going on. Or refactor it to put the time_after in the while(),
>>> as this is what the loop is waiting on.
>>
>> OK, I went in circles (pun intended) working on this loop, but I'll try
>> and make it look better.
>>
>>
>>>>           /* Extract size of response data */
>>>>           resp_data_length = get_unaligned_be16(&resp->data_length);
>>>> @@ -543,17 +556,29 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>>>>                   goto done;
>>>>           }
>>>>
>>>> -       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>>>> -               resp->return_status, resp_data_length);
>>>> -
>>>> -       /* Grab the rest */
>>>> +       /* Now get the entire response; get header again in case it changed */
>>>>           if (resp_data_length > 1) {
>>>> -               /* already got 3 bytes resp, also need 2 bytes checksum */
>>>> -               rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
>>>> +               rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
>>>>                   if (rc)
>>>>                           goto done;
>>>> +
>>>> +               if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
>>>> +                   resp->return_status == OCC_RESP_CRIT_INIT ||
>>>> +                   resp->seq_no != seq_no || resp->cmd_type != cmd_type) {
>>>> +                       if (!retried) {
>>>> +                               retried = true;
>>>> +                               goto retry;
>>> Not sure about this.
>>>
>>> How often did this situation come up?
>>>
>>> Did you consider instead returning an error here?
>>
>> Well I can't say it's frequent, but hitting this condition was what
>> drove making this change in the first place. It needs to be handled.
> I was concerned about the pattern of using goto back up the function.
>
> Would it make more sense the have the caller retry, instead of adding
> retries in the sbefifo driver?


I've refactored it in v2. I don't think making the caller retry makes 
sense, since it would be a lot of wasted work, since we only need to 
re-read the response at that point.


>
>> Previously if this occurrred, we got a checksum error, so it effectively
>> already returned an error.
>>
>>
>>>> +                       }
>>>> +
>>>> +                       fsi_occ_print_timeout(occ, resp, seq_no, cmd_type);
>>>> +                       rc = -ETIMEDOUT;
>>>> +                       goto done;
>>>> +               }
>>>>           }
>>>>
>>>> +       dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>>>> +               resp->return_status, resp_data_length);
>>>> +
>>>>           occ->client_response_size = resp_data_length + 7;
>>>>           rc = occ_verify_checksum(occ, resp, resp_data_length);
>>>>
>>>> @@ -598,7 +623,7 @@ static int occ_probe(struct platform_device *pdev)
>>>>           occ->version = (uintptr_t)of_device_get_match_data(dev);
>>>>           occ->dev = dev;
>>>>           occ->sbefifo = dev->parent;
>>>> -       occ->sequence_number = 1;
>>>> +       occ->sequence_number = (u8)((jiffies % 0xff) + 1);
>>> This is interesting. You didn't mention this in the commit message;
>>> you're trying to get a random number for the sequence number?
>>
>> Yea, this reduces the chances of hitting that retry above. If it's
>> always 1, then every time the driver is bound it tries the first command
>> with the same sequence number. This is a problem when FSI scanning with
>> the host already running, as the driver gets unbound/rebound several
>> times in a row, and we easily hit the checksum problem, since we proceed
>> to get the full response even though it's not for the latest command,
>> and then the buffer is updated at the same time. So using a non-zero
>> random number is very helpful.
> Makes sense. Perhaps do something like this instead of hand rolling it?
>
> get_random_bytes(occ->sequence_number, 1);


I thought about this, but I ended up just adding a comment and sticking 
with jiffies. get_random_bytes seems a little heavy-handed, especially 
since you're supposed to call wait_for_random_bytes first.


Thanks,

Eddie


>
> If you could add some of your explanations to the commit message, I'd
> like to get this fix merged soon.
>
> Cheers,
>
> Joel
>
>
>
>>
>> Thanks,
>>
>> Eddie
>>
>>
>>>>           mutex_init(&occ->occ_lock);
>>>>
>>>>           if (dev->of_node) {
>>>> --
>>>> 2.27.0
>>>>
