Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF254572F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbiFIWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbiFIWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:19:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B7C457BC;
        Thu,  9 Jun 2022 15:19:20 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259LqV4d021237;
        Thu, 9 Jun 2022 22:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5HFels0siO9Bs1KgO2JhJGYpJaNAG8PeqPH7KCpQZ8I=;
 b=iAzYl3HGbDPjGXTh3OP2TMtL8+E00E4alPACUjc12mHEx1F0g4Wav7UU13WA58TpKEN/
 v6svbQGfFE5DAdCcgmlNFzKBE+Eg000u0UbngUGaRd/c6ooO0uKyt8bL4tWzFKvEH80x
 w3pe1l2FoKqhiHzfDe0FNnF7eEOGiyQ//lcjABbhVvN3CyO8iJL8P/m9rSQR2RFK4Jqf
 ZvD55hb1u8ldwCuT+DqIv4ppav4SCUQUf3IjuBlPaM7mQLxC4GlYpocdXVXrVmdKSxG1
 Io++Oyg5UxHMfTpYFdaQswQqtjpC6/7M3jgumv2ROuP29D2kSIu3MfU8vvZRNRU/0hjV RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gks5cgctx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 22:18:51 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259MD8WL005156;
        Thu, 9 Jun 2022 22:18:51 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gks5cgct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 22:18:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259M6fwY027968;
        Thu, 9 Jun 2022 22:18:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19ff4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 22:18:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259MIkPq9175434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 22:18:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEFFC4C044;
        Thu,  9 Jun 2022 22:18:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD1FF4C040;
        Thu,  9 Jun 2022 22:18:44 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 22:18:44 +0000 (GMT)
Message-ID: <5db507747b2be22499e7357ce65f1800b36e1de4.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Date:   Thu, 09 Jun 2022 18:18:44 -0400
In-Reply-To: <20220512070123.29486-3-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
         <20220512070123.29486-3-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7wDBaP3m-VYgn90ZlORpX0j8Rd3YzlsY
X-Proofpoint-GUID: BG6JqiSb9BIi2R873tnMtsXFSjA4dDlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=781
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,

On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
> signature verify") adds platform keyring support on x86 kexec but not
> arm64.
> 
> The code in bzImage64_verify_sig makes use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
> verify signed kernel image as PE file. Make it generic so both x86_64
> and arm64 can use it.

^uses the keys on the .builtin_trusted_keys, .machine, if configured
and enabled, .secondary_trusted_keys, also if configured, and .platform
keyrings to verify the signed kernel image as PE file. 

> 
> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 const Elf_Shdr *relsec,
>  				 const Elf_Shdr *symtab);
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#ifdef CONFIG_KEXEC_SIG
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);

Please join this line with the previous one.

> +#endif
> +#endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);

thanks,

Mimi

