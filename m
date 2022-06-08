Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F4543237
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiFHOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiFHOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17013187040;
        Wed,  8 Jun 2022 07:07:06 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258Dqu0o029917;
        Wed, 8 Jun 2022 14:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=39Ca4a3Md+Hc70zQo+UAWuhiFvfpzoTugoYEFhYj4mk=;
 b=iuEKEpZxxdzHVGj57VWYGT6iNqLwr87w3eFRVSQE6z3n48zg5eK7ZQEi78XFuHjJrucZ
 Q9MtP3Q+rRrtOU3ZlnrxOIeKbpUK8nuqUjkbzKTbRggKzJPLHyjQCDKrjuymQPVBxGQ+
 1xmRb4DgnfWM4TiFQUmlW6CtUMjF8KSKuUU45GipUwBiqZZjPtsOldvrI92PiqDcsR0l
 eJZ168X+rnjv6coTzDx8KR9vh0p4X/vbQBDi4OCNEvFYdVDges7cFkNINSynu9r942b6
 ZdtP44EbQduL8WSOreKW48EV9vxhraNcNGyFErykCTJ7XMmhZLR+F5UWsCXGNllklu8T Ag== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjw1w0b32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:06:50 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258E6bdF020970;
        Wed, 8 Jun 2022 14:06:49 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3gfy1aaj57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:06:49 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258E6mr115532472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 14:06:48 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 490EC6E050;
        Wed,  8 Jun 2022 14:06:48 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 916266E04E;
        Wed,  8 Jun 2022 14:06:47 +0000 (GMT)
Received: from [9.77.153.97] (unknown [9.77.153.97])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jun 2022 14:06:47 +0000 (GMT)
Message-ID: <bcb52b09-d6b0-1095-fb62-a940f7e890ae@linux.ibm.com>
Date:   Wed, 8 Jun 2022 09:06:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] hwmon (occ): Delay hwmon registration until user
 request
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
References: <20220427140443.11428-1-eajames@linux.ibm.com>
 <20220427143454.GA3193568@roeck-us.net>
 <CACPK8Xcp1wsH_=EST=OhkknuCxhbC2UB9TQ78XtCkUGcS0B6_Q@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xcp1wsH_=EST=OhkknuCxhbC2UB9TQ78XtCkUGcS0B6_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q7jcQ1BIpj6aUFG5CZY4W0opKqup7VdY
X-Proofpoint-GUID: Q7jcQ1BIpj6aUFG5CZY4W0opKqup7VdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_04,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/22 02:13, Joel Stanley wrote:
> On Wed, 27 Apr 2022 at 14:34, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Apr 27, 2022 at 09:04:43AM -0500, Eddie James wrote:
>>> Instead of registering the hwmon device at probe time, use the
>>> existing "occ_active" sysfs file to control when the driver polls
>>> the OCC for sensor data and registers with hwmon. The reason for
>>> this change is that the SBE, which is the device by which the
>>> driver communicates with the OCC, cannot handle communications
>>> during certain system state transitions, resulting in
>>> unrecoverable system errors.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Applied to hwmon-next.
> Will this change break existing userspace? As I understand it existing
> systems rely on the driver probing for the occ without extra
> interaction.


Yes, the one application that uses this driver will not work correctly 
if it's not updated to the latest version. For BMCs, typically kernels 
and userspace are built and installed together, so I don't anticipate 
any problems for end users.


>
>  From your commit message, it sounds like we should inhibit SBE
> communication during the sensitive period. This would stop any
> devices, not just the OCC, from generating unwanted traffic.


That is true, and could be a good option, however it would require a 
brand new interface to the SBE FIFO driver. This change re-uses the 
occ_active file to effect the desired behavior.


Thanks,

Eddie


>
>> Guenter
>>
>>> ---
>>> Changes since v1:
>>>   - Update commit message to for clarity.
>>>
>>>   drivers/hwmon/occ/common.c | 100 +++++++++++++++++++--------
>>>   drivers/hwmon/occ/common.h |   5 +-
>>>   drivers/hwmon/occ/p8_i2c.c |   2 +-
>>>   drivers/hwmon/occ/p9_sbe.c |   2 +-
>>>   drivers/hwmon/occ/sysfs.c  | 137 ++++++++++++++++++++++---------------
>>>   5 files changed, 156 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
>>> index f00cd59f1d19..d78f4bebc718 100644
>>> --- a/drivers/hwmon/occ/common.c
>>> +++ b/drivers/hwmon/occ/common.c
>>> @@ -1149,44 +1149,75 @@ static void occ_parse_poll_response(struct occ *occ)
>>>                sizeof(*header), size + sizeof(*header));
>>>   }
>>>
>>> -int occ_setup(struct occ *occ, const char *name)
>>> +int occ_active(struct occ *occ, bool active)
>>>   {
>>> -     int rc;
>>> -
>>> -     mutex_init(&occ->lock);
>>> -     occ->groups[0] = &occ->group;
>>> +     int rc = mutex_lock_interruptible(&occ->lock);
>>>
>>> -     /* no need to lock */
>>> -     rc = occ_poll(occ);
>>> -     if (rc == -ESHUTDOWN) {
>>> -             dev_info(occ->bus_dev, "host is not ready\n");
>>> -             return rc;
>>> -     } else if (rc < 0) {
>>> -             dev_err(occ->bus_dev,
>>> -                     "failed to get OCC poll response=%02x: %d\n",
>>> -                     occ->resp.return_status, rc);
>>> +     if (rc)
>>>                return rc;
>>> -     }
>>>
>>> -     occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
>>> -     occ_parse_poll_response(occ);
>>> +     if (active) {
>>> +             if (occ->active) {
>>> +                     rc = -EALREADY;
>>> +                     goto unlock;
>>> +             }
>>>
>>> -     rc = occ_setup_sensor_attrs(occ);
>>> -     if (rc) {
>>> -             dev_err(occ->bus_dev, "failed to setup sensor attrs: %d\n",
>>> -                     rc);
>>> -             return rc;
>>> -     }
>>> +             occ->error_count = 0;
>>> +             occ->last_safe = 0;
>>>
>>> -     occ->hwmon = devm_hwmon_device_register_with_groups(occ->bus_dev, name,
>>> -                                                         occ, occ->groups);
>>> -     if (IS_ERR(occ->hwmon)) {
>>> -             rc = PTR_ERR(occ->hwmon);
>>> -             dev_err(occ->bus_dev, "failed to register hwmon device: %d\n",
>>> -                     rc);
>>> -             return rc;
>>> +             rc = occ_poll(occ);
>>> +             if (rc < 0) {
>>> +                     dev_err(occ->bus_dev,
>>> +                             "failed to get OCC poll response=%02x: %d\n",
>>> +                             occ->resp.return_status, rc);
>>> +                     goto unlock;
>>> +             }
>>> +
>>> +             occ->active = true;
>>> +             occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
>>> +             occ_parse_poll_response(occ);
>>> +
>>> +             rc = occ_setup_sensor_attrs(occ);
>>> +             if (rc) {
>>> +                     dev_err(occ->bus_dev,
>>> +                             "failed to setup sensor attrs: %d\n", rc);
>>> +                     goto unlock;
>>> +             }
>>> +
>>> +             occ->hwmon = hwmon_device_register_with_groups(occ->bus_dev,
>>> +                                                            "occ", occ,
>>> +                                                            occ->groups);
>>> +             if (IS_ERR(occ->hwmon)) {
>>> +                     rc = PTR_ERR(occ->hwmon);
>>> +                     occ->hwmon = NULL;
>>> +                     dev_err(occ->bus_dev,
>>> +                             "failed to register hwmon device: %d\n", rc);
>>> +                     goto unlock;
>>> +             }
>>> +     } else {
>>> +             if (!occ->active) {
>>> +                     rc = -EALREADY;
>>> +                     goto unlock;
>>> +             }
>>> +
>>> +             if (occ->hwmon)
>>> +                     hwmon_device_unregister(occ->hwmon);
>>> +             occ->active = false;
>>> +             occ->hwmon = NULL;
>>>        }
>>>
>>> +unlock:
>>> +     mutex_unlock(&occ->lock);
>>> +     return rc;
>>> +}
>>> +
>>> +int occ_setup(struct occ *occ)
>>> +{
>>> +     int rc;
>>> +
>>> +     mutex_init(&occ->lock);
>>> +     occ->groups[0] = &occ->group;
>>> +
>>>        rc = occ_setup_sysfs(occ);
>>>        if (rc)
>>>                dev_err(occ->bus_dev, "failed to setup sysfs: %d\n", rc);
>>> @@ -1195,6 +1226,15 @@ int occ_setup(struct occ *occ, const char *name)
>>>   }
>>>   EXPORT_SYMBOL_GPL(occ_setup);
>>>
>>> +void occ_shutdown(struct occ *occ)
>>> +{
>>> +     occ_shutdown_sysfs(occ);
>>> +
>>> +     if (occ->hwmon)
>>> +             hwmon_device_unregister(occ->hwmon);
>>> +}
>>> +EXPORT_SYMBOL_GPL(occ_shutdown);
>>> +
>>>   MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
>>>   MODULE_DESCRIPTION("Common OCC hwmon code");
>>>   MODULE_LICENSE("GPL");
>>> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
>>> index 2dd4a4d240c0..64d5ec7e169b 100644
>>> --- a/drivers/hwmon/occ/common.h
>>> +++ b/drivers/hwmon/occ/common.h
>>> @@ -106,6 +106,7 @@ struct occ {
>>>        struct attribute_group group;
>>>        const struct attribute_group *groups[2];
>>>
>>> +     bool active;
>>>        int error;                      /* final transfer error after retry */
>>>        int last_error;                 /* latest transfer error */
>>>        unsigned int error_count;       /* number of xfr errors observed */
>>> @@ -123,9 +124,11 @@ struct occ {
>>>        u8 prev_mode;
>>>   };
>>>
>>> -int occ_setup(struct occ *occ, const char *name);
>>> +int occ_active(struct occ *occ, bool active);
>>> +int occ_setup(struct occ *occ);
>>>   int occ_setup_sysfs(struct occ *occ);
>>>   void occ_shutdown(struct occ *occ);
>>> +void occ_shutdown_sysfs(struct occ *occ);
>>>   void occ_sysfs_poll_done(struct occ *occ);
>>>   int occ_update_response(struct occ *occ);
>>>
>>> diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
>>> index 9e61e1fb5142..da39ea28df31 100644
>>> --- a/drivers/hwmon/occ/p8_i2c.c
>>> +++ b/drivers/hwmon/occ/p8_i2c.c
>>> @@ -223,7 +223,7 @@ static int p8_i2c_occ_probe(struct i2c_client *client)
>>>        occ->poll_cmd_data = 0x10;              /* P8 OCC poll data */
>>>        occ->send_cmd = p8_i2c_occ_send_cmd;
>>>
>>> -     return occ_setup(occ, "p8_occ");
>>> +     return occ_setup(occ);
>>>   }
>>>
>>>   static int p8_i2c_occ_remove(struct i2c_client *client)
>>> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
>>> index 49b13cc01073..42fc7b97bb34 100644
>>> --- a/drivers/hwmon/occ/p9_sbe.c
>>> +++ b/drivers/hwmon/occ/p9_sbe.c
>>> @@ -145,7 +145,7 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>>>        occ->poll_cmd_data = 0x20;              /* P9 OCC poll data */
>>>        occ->send_cmd = p9_sbe_occ_send_cmd;
>>>
>>> -     rc = occ_setup(occ, "p9_occ");
>>> +     rc = occ_setup(occ);
>>>        if (rc == -ESHUTDOWN)
>>>                rc = -ENODEV;   /* Host is shutdown, don't spew errors */
>>>
>>> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
>>> index b2f788a77746..2317301fc1e9 100644
>>> --- a/drivers/hwmon/occ/sysfs.c
>>> +++ b/drivers/hwmon/occ/sysfs.c
>>> @@ -6,13 +6,13 @@
>>>   #include <linux/export.h>
>>>   #include <linux/hwmon-sysfs.h>
>>>   #include <linux/kernel.h>
>>> +#include <linux/kstrtox.h>
>>>   #include <linux/sysfs.h>
>>>
>>>   #include "common.h"
>>>
>>>   /* OCC status register */
>>>   #define OCC_STAT_MASTER                      BIT(7)
>>> -#define OCC_STAT_ACTIVE                      BIT(0)
>>>
>>>   /* OCC extended status register */
>>>   #define OCC_EXT_STAT_DVFS_OT         BIT(7)
>>> @@ -22,6 +22,25 @@
>>>   #define OCC_EXT_STAT_DVFS_VDD                BIT(3)
>>>   #define OCC_EXT_STAT_GPU_THROTTLE    GENMASK(2, 0)
>>>
>>> +static ssize_t occ_active_store(struct device *dev,
>>> +                             struct device_attribute *attr,
>>> +                             const char *buf, size_t count)
>>> +{
>>> +     int rc;
>>> +     bool active;
>>> +     struct occ *occ = dev_get_drvdata(dev);
>>> +
>>> +     rc = kstrtobool(buf, &active);
>>> +     if (rc)
>>> +             return rc;
>>> +
>>> +     rc = occ_active(occ, active);
>>> +     if (rc)
>>> +             return rc;
>>> +
>>> +     return count;
>>> +}
>>> +
>>>   static ssize_t occ_sysfs_show(struct device *dev,
>>>                              struct device_attribute *attr, char *buf)
>>>   {
>>> @@ -31,54 +50,64 @@ static ssize_t occ_sysfs_show(struct device *dev,
>>>        struct occ_poll_response_header *header;
>>>        struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>>>
>>> -     rc = occ_update_response(occ);
>>> -     if (rc)
>>> -             return rc;
>>> +     if (occ->active) {
>>> +             rc = occ_update_response(occ);
>>> +             if (rc)
>>> +                     return rc;
>>>
>>> -     header = (struct occ_poll_response_header *)occ->resp.data;
>>> -
>>> -     switch (sattr->index) {
>>> -     case 0:
>>> -             val = !!(header->status & OCC_STAT_MASTER);
>>> -             break;
>>> -     case 1:
>>> -             val = !!(header->status & OCC_STAT_ACTIVE);
>>> -             break;
>>> -     case 2:
>>> -             val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
>>> -             break;
>>> -     case 3:
>>> -             val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
>>> -             break;
>>> -     case 4:
>>> -             val = !!(header->ext_status & OCC_EXT_STAT_MEM_THROTTLE);
>>> -             break;
>>> -     case 5:
>>> -             val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
>>> -             break;
>>> -     case 6:
>>> -             val = header->occ_state;
>>> -             break;
>>> -     case 7:
>>> -             if (header->status & OCC_STAT_MASTER)
>>> -                     val = hweight8(header->occs_present);
>>> -             else
>>> +             header = (struct occ_poll_response_header *)occ->resp.data;
>>> +
>>> +             switch (sattr->index) {
>>> +             case 0:
>>> +                     val = !!(header->status & OCC_STAT_MASTER);
>>> +                     break;
>>> +             case 1:
>>>                        val = 1;
>>> -             break;
>>> -     case 8:
>>> -             val = header->ips_status;
>>> -             break;
>>> -     case 9:
>>> -             val = header->mode;
>>> -             break;
>>> -     case 10:
>>> -             val = !!(header->ext_status & OCC_EXT_STAT_DVFS_VDD);
>>> -             break;
>>> -     case 11:
>>> -             val = header->ext_status & OCC_EXT_STAT_GPU_THROTTLE;
>>> -             break;
>>> -     default:
>>> -             return -EINVAL;
>>> +                     break;
>>> +             case 2:
>>> +                     val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
>>> +                     break;
>>> +             case 3:
>>> +                     val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
>>> +                     break;
>>> +             case 4:
>>> +                     val = !!(header->ext_status &
>>> +                              OCC_EXT_STAT_MEM_THROTTLE);
>>> +                     break;
>>> +             case 5:
>>> +                     val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
>>> +                     break;
>>> +             case 6:
>>> +                     val = header->occ_state;
>>> +                     break;
>>> +             case 7:
>>> +                     if (header->status & OCC_STAT_MASTER)
>>> +                             val = hweight8(header->occs_present);
>>> +                     else
>>> +                             val = 1;
>>> +                     break;
>>> +             case 8:
>>> +                     val = header->ips_status;
>>> +                     break;
>>> +             case 9:
>>> +                     val = header->mode;
>>> +                     break;
>>> +             case 10:
>>> +                     val = !!(header->ext_status & OCC_EXT_STAT_DVFS_VDD);
>>> +                     break;
>>> +             case 11:
>>> +                     val = header->ext_status & OCC_EXT_STAT_GPU_THROTTLE;
>>> +                     break;
>>> +             default:
>>> +                     return -EINVAL;
>>> +             }
>>> +     } else {
>>> +             if (sattr->index == 1)
>>> +                     val = 0;
>>> +             else if (sattr->index <= 11)
>>> +                     val = -ENODATA;
>>> +             else
>>> +                     return -EINVAL;
>>>        }
>>>
>>>        return sysfs_emit(buf, "%d\n", val);
>>> @@ -95,7 +124,8 @@ static ssize_t occ_error_show(struct device *dev,
>>>   }
>>>
>>>   static SENSOR_DEVICE_ATTR(occ_master, 0444, occ_sysfs_show, NULL, 0);
>>> -static SENSOR_DEVICE_ATTR(occ_active, 0444, occ_sysfs_show, NULL, 1);
>>> +static SENSOR_DEVICE_ATTR(occ_active, 0644, occ_sysfs_show, occ_active_store,
>>> +                       1);
>>>   static SENSOR_DEVICE_ATTR(occ_dvfs_overtemp, 0444, occ_sysfs_show, NULL, 2);
>>>   static SENSOR_DEVICE_ATTR(occ_dvfs_power, 0444, occ_sysfs_show, NULL, 3);
>>>   static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
>>> @@ -139,7 +169,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>>>         * On the first poll response, we haven't yet created the sysfs
>>>         * attributes, so don't make any notify calls.
>>>         */
>>> -     if (!occ->hwmon)
>>> +     if (!occ->active)
>>>                goto done;
>>>
>>>        if ((header->status & OCC_STAT_MASTER) !=
>>> @@ -148,12 +178,6 @@ void occ_sysfs_poll_done(struct occ *occ)
>>>                sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>>>        }
>>>
>>> -     if ((header->status & OCC_STAT_ACTIVE) !=
>>> -         (occ->prev_stat & OCC_STAT_ACTIVE)) {
>>> -             name = sensor_dev_attr_occ_active.dev_attr.attr.name;
>>> -             sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>>> -     }
>>> -
>>>        if ((header->ext_status & OCC_EXT_STAT_DVFS_OT) !=
>>>            (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_OT)) {
>>>                name = sensor_dev_attr_occ_dvfs_overtemp.dev_attr.attr.name;
>>> @@ -227,8 +251,7 @@ int occ_setup_sysfs(struct occ *occ)
>>>        return sysfs_create_group(&occ->bus_dev->kobj, &occ_sysfs);
>>>   }
>>>
>>> -void occ_shutdown(struct occ *occ)
>>> +void occ_shutdown_sysfs(struct occ *occ)
>>>   {
>>>        sysfs_remove_group(&occ->bus_dev->kobj, &occ_sysfs);
>>>   }
>>> -EXPORT_SYMBOL_GPL(occ_shutdown);
