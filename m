Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B4531092
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiEWLyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiEWLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:54:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEAF51587;
        Mon, 23 May 2022 04:54:19 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NBhnkE001648;
        Mon, 23 May 2022 11:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : cc : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=m2M041NPkinmobUzSjYQMqGg1ZNgckVlTpZZMS9CAfk=;
 b=cDksBTLxb0VNOyHXwoEwAeDjY8BPMakKa+ERnd/3xfCv0Qv7LaNwZ+aeZskd6BBYhz4f
 SUJIgkLmP97lm9mBOLxQ+XtJ3sosKmoAQQQBc3DZ0aLTKR5ICIHT+gaIb4tj2qu+obPb
 lsLjECJHeNeh7zIwkAfDhl3MsQjc/f8D9EdbXtJZGuJj4SP5xlRddi5AxUyfPoN5J+ys
 kYhg/mLScDYKV+Z5DsnKgIS1KxG14Sv6B7HkiqZQi6uNwenUQvEXqGOpVBpM13fVTKgh
 WwsOmXqwMxOGNFPscVseldoZ2tvAQCzmN78mY4tNo9OYDffSSsFoz1TWLGsuU6Mj7S+p Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g89n485s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 11:54:07 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NBnUG1020797;
        Mon, 23 May 2022 11:54:07 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g89n485rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 11:54:06 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NBAC7I025664;
        Mon, 23 May 2022 11:54:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3g6qqabnpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 11:54:05 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NBs4WW63177170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 11:54:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C40ECB2065;
        Mon, 23 May 2022 11:54:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8652AB205F;
        Mon, 23 May 2022 11:54:00 +0000 (GMT)
Received: from [9.43.92.112] (unknown [9.43.92.112])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 23 May 2022 11:54:00 +0000 (GMT)
Message-ID: <a1a2eaea-4483-68b0-352f-f7d357a4d14b@linux.vnet.ibm.com>
Date:   Mon, 23 May 2022 17:23:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Subject: OpenSSL's ENGINE API is deprecated in OpenSSL v3.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MtgIgFkQajuNsL1yPYvgq0uRGt9yelAs
X-Proofpoint-GUID: GCgM9psdrN3pqKogPfwdqVCHEdeLHjhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_04,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=526 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

OpenSSL's ENGINE API is deprecated in OpenSSL v3.0

Console logs :

[console-expect]#make -j 17 -s && make modules && make modules_install 
&& make install
make -j 17 -s && make modules && make modules_install && make install
scripts/sign-file.c: In function 'display_openssl_errors':
scripts/sign-file.c:89:2: warning: 'ERR_get_error_line' is deprecated: 
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   while ((e = ERR_get_error_line(&file, &line))) {
   ^~~~~
In file included from scripts/sign-file.c:29:0:
/usr/include/openssl/err.h:411:15: note: declared here
  unsigned long ERR_get_error_line(const char **file, int *line);
                ^~~~~~~~~~~~~~~~~~
scripts/sign-file.c: In function 'drain_openssl_errors':
scripts/sign-file.c:102:2: warning: 'ERR_get_error_line' is deprecated: 
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   while (ERR_get_error_line(&file, &line)) {}
   ^~~~~
In file included from scripts/sign-file.c:29:0:
/usr/include/openssl/err.h:411:15: note: declared here
  unsigned long ERR_get_error_line(const char **file, int *line);
                ^~~~~~~~~~~~~~~~~~
scripts/sign-file.c: In function 'read_private_key':
scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines' is 
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
    ENGINE_load_builtin_engines();
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from scripts/sign-file.c:30:0:
/usr/include/openssl/engine.h:358:28: note: declared here
  OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sign-file.c:144:3: warning: 'ENGINE_by_id' is deprecated: Since 
OpenSSL 3.0 [-Wdeprecated-declarations]
    e = ENGINE_by_id("pkcs11");
    ^
In file included from scripts/sign-file.c:30:0:
/usr/include/openssl/engine.h:336:31: note: declared here
  OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
                                ^~~~~~~~~~~~
scripts/sign-file.c:146:3: warning: 'ENGINE_init' is deprecated: Since 
OpenSSL 3.0 [-Wdeprecated-declarations]
    if (ENGINE_init(e))
    ^~
In file included from scripts/sign-file.c:30:0:
/usr/include/openssl/engine.h:620:27: note: declared here
  OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
                            ^~~~~~~~~~~
scripts/sign-file.c:151:4: warning: 'ENGINE_ctrl_cmd_string' is 
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
     ^~~
In file included from scripts/sign-file.c:30:0:
/usr/include/openssl/engine.h:479:5: note: declared here
  int ENGINE_ctrl_cmd_string(ENGINE *e, const char *cmd_name, const char 
*arg,
      ^~~~~~~~~~~~~~~~~~~~~~
scripts/sign-file.c:153:3: warning: 'ENGINE_load_private_key' is 
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
    private_key = ENGINE_load_private_key(e, private_key_name,
    ^~~~~~~~~~~
In file included from scripts/sign-file.c:30:0:
/usr/include/openssl/engine.h:638:11: note: declared here
  EVP_PKEY *ENGINE_load_private_key(ENGINE *e, const char *key_id,
            ^~~~~~~~~~~~~~~~~~~~~~~
certs/extract-cert.c: In function 'display_openssl_errors':
certs/extract-cert.c:46:2: warning: 'ERR_get_error_line' is deprecated: 
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   while ((e = ERR_get_error_line(&file, &line))) {
   ^~~~~
In file included from certs/extract-cert.c:23:0:
/usr/include/openssl/err.h:411:15: note: declared here
  unsigned long ERR_get_error_line(const char **file, int *line);
                ^~~~~~~~~~~~~~~~~~
certs/extract-cert.c: In function 'drain_openssl_errors':
certs/extract-cert.c:59:2: warning: 'ERR_get_error_line' is deprecated: 
Since OpenSSL 3.0 [-Wdeprecated-declarations]
   while (ERR_get_error_line(&file, &line)) {}
   ^~~~~
In file included from certs/extract-cert.c:23:0:
/usr/include/openssl/err.h:411:15: note: declared here
  unsigned long ERR_get_error_line(const char **file, int *line);
                ^~~~~~~~~~~~~~~~~~
certs/extract-cert.c: In function 'main':
certs/extract-cert.c:124:3: warning: 'ENGINE_load_builtin_engines' is 
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
    ENGINE_load_builtin_engines();
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from certs/extract-cert.c:24:0:
/usr/include/openssl/engine.h:358:28: note: declared here
  OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
certs/extract-cert.c:126:3: warning: 'ENGINE_by_id' is deprecated: Since 
OpenSSL 3.0 [-Wdeprecated-declarations]
    e = ENGINE_by_id("pkcs11");
    ^
In file included from certs/extract-cert.c:24:0:
/usr/include/openssl/engine.h:336:31: note: declared here
  OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
                                ^~~~~~~~~~~~
certs/extract-cert.c:128:3: warning: 'ENGINE_init' is deprecated: Since 
OpenSSL 3.0 [-Wdeprecated-declarations]
    if (ENGINE_init(e))
    ^~
In file included from certs/extract-cert.c:24:0:
/usr/include/openssl/engine.h:620:27: note: declared here
  OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
                            ^~~~~~~~~~~
certs/extract-cert.c:133:4: warning: 'ENGINE_ctrl_cmd_string' is 
deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
     ^~~
In file included from certs/extract-cert.c:24:0:
/usr/include/openssl/engine.h:479:5: note: declared here
  int ENGINE_ctrl_cmd_string(ENGINE *e, const char *cmd_name, const char 
*arg,
      ^~~~~~~~~~~~~~~~~~~~~~
certs/extract-cert.c:134:3: warning: 'ENGINE_ctrl_cmd' is deprecated: 
Since OpenSSL 3.0 [-Wdeprecated-declarations]
    ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
    ^~~~~~~~~~~~~~~
In file included from certs/extract-cert.c:24:0:
/usr/include/openssl/engine.h:450:27: note: declared here
  OSSL_DEPRECATEDIN_3_0 int ENGINE_ctrl_cmd(ENGINE *e, const char *cmd_name,
                            ^~~~~~~~~~~~~~~

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center
