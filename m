Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8A5456C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiFIV6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiFIV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:58:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB6160872
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:58:05 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259LeP1f001277;
        Thu, 9 Jun 2022 21:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/4BBPAchM/ULle0Yy7F5eLNhfs7+FxPP29f9TFF6zSk=;
 b=cQOJ/HYrto4UP/nF+Ekz3ZIO4C5XXUumppXukg4aPfBEFba4yu1EMXNktT5I1ll4Ubl1
 xLYKnChP5Cbs66SY6K9SYvh58GrqUWthlCauKNJUDpGbcoZaMRXL5UdTdPUkWDI0f4tY
 ZrrPBHwOjAC/fS+1vC2fpf/4ow/MDsME8fL6pQWEjdaO4IgzcViFOuAWfVTbzW1bz/Ay
 OowS7AfgNut8vXKaCIzI7D9osv++Cf2DHUdqsS2ll/Sljt68HFR6mGuq9Tj4Y5RG5Aeu
 atACxURUD9UWXbirKCclYd9ybycWvhO+ekGcGvFESt6evVHEn6XdhjQ076ftuYidc7fF FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkrysg7we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 21:57:48 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259LpHU6011517;
        Thu, 9 Jun 2022 21:57:48 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkrysg7vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 21:57:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259LoYqO015642;
        Thu, 9 Jun 2022 21:57:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19fek5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 21:57:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259LvNHZ16187656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 21:57:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 870DB11C054;
        Thu,  9 Jun 2022 21:57:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5821C11C04A;
        Thu,  9 Jun 2022 21:57:42 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 21:57:42 +0000 (GMT)
Message-ID: <97fe71b97d0fe70511e9747823d98a8409dc43d7.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] kexec: clean up arch_kexec_kernel_verify_sig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 09 Jun 2022 17:57:41 -0400
In-Reply-To: <20220512070123.29486-2-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
         <20220512070123.29486-2-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7BlaBGA9OOIOErFZqxHIP-5vXPRyI_oe
X-Proofpoint-ORIG-GUID: 4qbOklQPAMwShicpIiAG1mOYuTtXHJ8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
>  kimage_validate_signature(struct kimage *image)
>  {
>         int ret;
>  
> -       ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
> -                                          image->kernel_buf_len);
> +       ret = kexec_image_verify_sig(image, image->kernel_buf,
> +                       image->kernel_buf_len);

Please indent the above line to line up with the open parenthesis.

thanks,

Mimi

>         if (ret) {
>  
>                 if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {


