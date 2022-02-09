Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978E04AEFE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiBILWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBILWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:22:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E36E08E457
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:16:23 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21975wJM007609;
        Wed, 9 Feb 2022 09:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wvm5YIaS7ro2Fs/QQiFJb+9ymuruMtS8dhHGq+seETY=;
 b=qRVuC7b9aJ3jd3dcXaKg30zoW/AbmzqvLvvqMudTwSdx/G2iMqvqA8uB7i2Jja90DXWg
 DvAwC96urYT4buuE7pq8hdva6KkgIkIZi0YK7A7TK3l8k7f1pBkOR0FsDXBpEQ9AunUf
 7daYqTkoA0PWa/SzNrz4Dlnaqu2n9x79aojvg2jt4yoVsCldrQuHguETCanxDvI8pmWR
 2oPkVpENF0DNe4Y9uEz2g3j/iVaw5w82185VeTZ/OEuO2REOA38B4hJJLeJb3OpEwj3J
 6e0lMdMRtu00kga4FA0Q6YHJchApotYyvrRWaNfS0J89q6q96Id0NS6d7fBoAUhx+4EV oA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3ny977gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 09:13:22 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21994u8E025375;
        Wed, 9 Feb 2022 09:13:22 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3e3gq00pq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 09:13:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2199DJYx26280242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 09:13:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 325C2112067;
        Wed,  9 Feb 2022 09:13:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E5CC112061;
        Wed,  9 Feb 2022 09:13:17 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 09:13:17 +0000 (GMT)
Message-ID: <0d33cac6-99a7-e756-e0e3-37124784e3bb@linux.ibm.com>
Date:   Wed, 9 Feb 2022 11:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 2/2] pseries: define sysfs interface to expose PKS
 variables
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        George Wilson <gcwilson@linux.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>, gjoyce@ibm.com,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220122005637.28199-1-nayna@linux.ibm.com>
 <20220122005637.28199-3-nayna@linux.ibm.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220122005637.28199-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ryuf2rR1vgn2ZkvPJiIheYi1GKSMlzaC
X-Proofpoint-ORIG-GUID: Ryuf2rR1vgn2ZkvPJiIheYi1GKSMlzaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_04,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,


On 22/01/2022 2:56, Nayna Jain wrote:
> PowerVM guest secure boot intend to use Platform Keystore(PKS) for the
> purpose of storing public keys to verify digital signature.
> 
> Define sysfs interface to expose PKS variables to userspace to allow
> read/write/add/delete operations. Each variable is shown as a read/write
> attribute file. The size of the file represents the size of the current
> content of the variable.
> 
> create_var and delete_var attribute files are always present which allow
> users to create/delete variables. These are write only attributes.The
> design has tried to be compliant with sysfs semantic to represent single
> value per attribute. Thus, rather than mapping a complete data structure
> representation to create_var, it only accepts a single formatted string
> to create an empty variable.
> 
> The sysfs interface is designed such as to expose PKS configuration
> properties, operating system variables and firmware variables.
> Current version exposes configuration and operating system variables.
> The support for exposing firmware variables will be added in the future
> version.
> 
> Example of pksvar sysfs interface:
> 
> # cd /sys/firmware/pksvar/
> # ls
> config  os
> 
> # cd config
> 
> # ls -ltrh
> total 0
> -r--r--r-- 1 root root 64K Jan 21 17:55 version
> -r--r--r-- 1 root root 64K Jan 21 17:55 used_space
> -r--r--r-- 1 root root 64K Jan 21 17:55 total_size
> -r--r--r-- 1 root root 64K Jan 21 17:55 supported_policies
> -r--r--r-- 1 root root 64K Jan 21 17:55 max_object_size
> -r--r--r-- 1 root root 64K Jan 21 17:55 max_object_label_size
> -r--r--r-- 1 root root 64K Jan 21 17:55 flags
> 
> # cd os
> 
> # ls -ltrh
> total 0
> -rw------- 1 root root 104 Jan 21 17:56 var4
> -rw------- 1 root root 104 Jan 21 17:56 var3
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_PK
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_KEK
> -rw------- 1 root root  76 Jan 21 17:56 GLOBAL_dbx
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_db
> --w------- 1 root root 64K Jan 21 17:56 delete_var
> --w------- 1 root root 64K Jan 21 17:56 create_var
> 
> 1. Read variable
> 
> # hexdump -C GLOBAL_db
> 00000000  00 00 00 00 a1 59 c0 a5  e4 94 a7 4a 87 b5 ab 15  |.....Y.....J....|
> 00000010  5c 2b f0 72 3f 03 00 00  00 00 00 00 23 03 00 00  |\+.r?.......#...|
> ....
> 00000330  02 a8 e8 ed 0f 20 60 3f  40 04 7c a8 91 21 37 eb  |..... `?@.|..!7.|
> 00000340  f3 f1 4e                                          |..N|
> 00000343
> 
> 2. Write variable
> 
> cat /tmp/data.bin > <variable_name>
> 
> 3. Create variable
> 
> # echo "var1" > create_var

It would be easier to understand if the user could create a new variable
like a regular new file, something like:

# cat /tmp/data.bin > var1

but I understand there are also comma-seperated-policy-strings which
should go somewhere; not sure how this fits (or if there are other
examples for similar interfaces in other sysfs parts).



> # ls -ltrh
> total 0
> -rw------- 1 root root 104 Jan 21 17:56 var4
> -rw------- 1 root root 104 Jan 21 17:56 var3
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_PK
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_KEK
> -rw------- 1 root root  76 Jan 21 17:56 GLOBAL_dbx
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_db
> --w------- 1 root root 64K Jan 21 17:56 delete_var
> --w------- 1 root root 64K Jan 21 17:57 create_var
> -rw------- 1 root root   0 Jan 21 17:57 var1.tmp
> 
> Current design creates a zero size temporary variable. This implies
> it is not yet persisted to PKS. Only once data is written to newly
> created temporary variable and if it is successfully stored in the
> PKS, that the variable is permanent. The temporary variable will get
> removed on reboot. The code currently doesn't remove .tmp suffix
> immediately when persisted. The future version will fix this.
> 
> To avoid the additional .tmp semantic, alternative option is to consider
> any zero size variable as temporary variable. This option is under
> evaluation. This would avoid any runtime sysfs magic to replace .tmp
> variable with real variable.
> 
> Also, the formatted string to pass to create_var will have following
> format in the future version:
> <variable_name>:<comma-separated-policy strings>
> 
> 4. Delete variable
> # echo "var3" > delete_var

If it's possible here, I think it would be easier to understand (and
use) if you implement unlink(), so deleting var3 would be:

# rm var3

(and then there's no need for the special 'delete_var' entry.)


-Dov

> # ls -ltrh
> total 0
> -rw------- 1 root root 104 Jan 21 17:56 var4
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_PK
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_KEK
> -rw------- 1 root root  76 Jan 21 17:56 GLOBAL_dbx
> -rw------- 1 root root 831 Jan 21 17:56 GLOBAL_db
> --w------- 1 root root 64K Jan 21 17:57 create_var
> -rw------- 1 root root   0 Jan 21 17:57 var1.tmp
> --w------- 1 root root 64K Jan 21 17:58 delete_var
> 
> The var3 file is removed at runtime, if variable is successfully
> removed from the PKS storage.
> 
> NOTE: We are evaluating two design for userspace interface: using the
> sysfs or defining a new filesystem based. Any feedback on this sysfs based
> approach would be highly appreciated. We have tried to follow one value
> per attribute semantic. If that or any other semantics aren't followed
> properly, please let us know.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-pksvar        |  77 ++++
>  arch/powerpc/platforms/pseries/Kconfig        |   7 +
>  arch/powerpc/platforms/pseries/Makefile       |   1 +
>  arch/powerpc/platforms/pseries/pksvar-sysfs.c | 356 ++++++++++++++++++
>  4 files changed, 441 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-pksvar
>  create mode 100644 arch/powerpc/platforms/pseries/pksvar-sysfs.c
> 

