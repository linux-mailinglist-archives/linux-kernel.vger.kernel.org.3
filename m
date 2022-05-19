Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323DF52CD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiESHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiESHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:50:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881FB0D33;
        Thu, 19 May 2022 00:50:01 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J7g4co021464;
        Thu, 19 May 2022 07:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=0MqWaHLxMrqSxXxnUck33JgO4j68MSSlKddCUp+T4VE=;
 b=FGzzW5zv6kXBeQa83sdEO6Dd10z2FXIcPUeQ+0yK9ka4uHqkugoGmBW0/m4JDqUK5yT/
 tRCL/9ZHFPLQ4wRuQwPVq8Bk6aaYhvo1hpZzHe8qJEwzFtCMsCyA9IHoVwrHMLiqoMFL
 O4i9muS+FbijL92oiN0MMW9fLCzVVvQF6GNrPuvjb/61ZWhWVxECEX1DMh/q0kugkVf9
 ph3JfctsTkfhNI8nrCCIl2uFD8cftgNHjM4xnu8DE9BhC0DKphF03CUupTBcmVrLEhLp
 emdJU2D3MvSP/62Ks5CABm574aArvDDLMYLQ+oI2mQ8tg/zsU/+M5a3CQhYS5rbxMa3r Ow== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5h4cgw5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 07:50:00 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J7mnsl018230;
        Thu, 19 May 2022 07:50:00 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3g4wp5ev7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 07:50:00 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J7nxg829360542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:49:59 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C061136051;
        Thu, 19 May 2022 07:49:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7DF2136059;
        Thu, 19 May 2022 07:49:56 +0000 (GMT)
Received: from [9.43.107.12] (unknown [9.43.107.12])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 May 2022 07:49:56 +0000 (GMT)
Message-ID: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
Date:   Thu, 19 May 2022 13:19:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
        sachinp@linux.vnet.com, mputtash@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HLMkLiJx7-xffnEbmbslD5z7Rzr3FK7m
X-Proofpoint-GUID: HLMkLiJx7-xffnEbmbslD5z7Rzr3FK7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxlogscore=748 impostorscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

linux-next build fails modpost: "blkcg_get_fc_appid" 
[drivers/nvme/host/nvme-fc.ko] undefined!

Console Logs :

[console-expect]#make -j 17 -s && make modules && make modules_install 
&& make install
make -j 17 -s && make modules && make modules_install && make install
ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] 
undefined!
make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
make: *** [Makefile:1914: modules] Error 2
make: *** Waiting for unfinished jobs....



-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
