Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E5596CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiHQKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiHQKbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:31:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA977EAC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:31:02 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HABrVO031772;
        Wed, 17 Aug 2022 10:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jKLT6C059gVhqqdv1FyZCASfK9RTFay1c9yVy+atreQ=;
 b=D5s22uxPujIiQtbtgPEKuIp3zne0jxE//QqaC3lDAgnYuYZSS3kWsbwi63fH+nOeFddc
 Kj6gM1Z4qwlABeS/JV/uvEWDEB7e8Vg4n39SVv2Zcy3tNCEgRmaN2wzT4cSCyOfn8p2n
 Oo9/TMU0d2eIte3OYvT44n6o8asvcjE/UpZLbjk1BI0nc5yf6cXG7jlMmN5sxeR6QuG8
 LKVgTasBmDN1zOP0RaVgEGBOixz9qqfl7ag+o7MkLFquMukdLfS1NGeEh1B6HlBSnnk9
 o+wfh3SC/6R//S3Lg3MOHUwLbQWczjnfxg/JGaxYN++o6zhU8M4CHHg+Agdem5l7peUj jw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0xc58fnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:30:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HALDEf012312;
        Wed, 17 Aug 2022 10:30:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3hx37j38ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:30:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HAUDEt31326564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 10:30:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74AF34204B;
        Wed, 17 Aug 2022 10:30:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2122342042;
        Wed, 17 Aug 2022 10:30:12 +0000 (GMT)
Received: from [9.171.42.210] (unknown [9.171.42.210])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 10:30:11 +0000 (GMT)
Message-ID: <f27b0f3a-5e89-1fb1-ac23-ed896ec7150f@linux.ibm.com>
Date:   Wed, 17 Aug 2022 12:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error:
 uninitialized symbol 'prot'.
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <202208140141.4uzWszG4-lkp@intel.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <202208140141.4uzWszG4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4AJuRRq2QRjHL-pXqTluvukzVaxtZtAG
X-Proofpoint-ORIG-GUID: 4AJuRRq2QRjHL-pXqTluvukzVaxtZtAG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 clxscore=1011
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 09:23, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
> commit: 7faa543df19bf62d4583a64d3902705747f2ad29 KVM: s390: gaccess: Refactor access address range check
> config: s390-randconfig-m031-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140141.4uzWszG4-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error: uninitialized symbol 'prot'.
> 
> vim +/prot +859 arch/s390/kvm/gaccess.c
> 
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  831  static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  832  			       unsigned long *gpas, unsigned long len,
> 92c9632119b67f David Hildenbrand        2015-11-16  833  			       const union asce asce, enum gacc_mode mode)
> 2293897805c2fe Heiko Carstens           2014-01-01  834  {
> 2293897805c2fe Heiko Carstens           2014-01-01  835  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  836  	unsigned int offset = offset_in_page(ga);
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  837  	unsigned int fragment_len;
> cde0dcfb5df1db David Hildenbrand        2016-05-31  838  	int lap_enabled, rc = 0;
> 6ae1574c2a24ee Christian Borntraeger    2017-06-07  839  	enum prot_type prot;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  840  	unsigned long gpa;
> 2293897805c2fe Heiko Carstens           2014-01-01  841  
> 75a1812230ad7a Alexander Yarygin        2015-01-22  842  	lap_enabled = low_address_protection_enabled(vcpu, asce);
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  843  	while (min(PAGE_SIZE - offset, len) > 0) {
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  844  		fragment_len = min(PAGE_SIZE - offset, len);
> 2293897805c2fe Heiko Carstens           2014-01-01  845  		ga = kvm_s390_logical_to_effective(vcpu, ga);
> cde0dcfb5df1db David Hildenbrand        2016-05-31  846  		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
> cde0dcfb5df1db David Hildenbrand        2016-05-31  847  			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
> cde0dcfb5df1db David Hildenbrand        2016-05-31  848  					 PROT_TYPE_LA);
> a752598254016d Heiko Carstens           2017-06-03  849  		if (psw_bits(*psw).dat) {
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  850  			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
> 2293897805c2fe Heiko Carstens           2014-01-01  851  			if (rc < 0)
> 2293897805c2fe Heiko Carstens           2014-01-01  852  				return rc;
> 2293897805c2fe Heiko Carstens           2014-01-01  853  		} else {
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  854  			gpa = kvm_s390_real_to_abs(vcpu, ga);
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  855  			if (kvm_is_error_gpa(vcpu->kvm, gpa))
> cde0dcfb5df1db David Hildenbrand        2016-05-31  856  				rc = PGM_ADDRESSING;
>                                                                                         ^^^^^^^^^^^^^^^^^^^^
> 
> "rc" set but "prot" not initialized.

prot is only used in case of PGM_PROTECTION.
Because of that, we could initialize prot to an arbitrary value, but that seems misleading and a bit ugly to me.
Alternatively, we could introduce a PROT_NONE.
Or we do nothing, since there is no actual problem.
@Janosch, @Claudio, what do you think?

> 
> 2293897805c2fe Heiko Carstens           2014-01-01  857  		}
> cde0dcfb5df1db David Hildenbrand        2016-05-31  858  		if (rc)
> 6ae1574c2a24ee Christian Borntraeger    2017-06-07 @859  			return trans_exc(vcpu, rc, ga, ar, mode, prot);
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  860  		if (gpas)
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  861  			*gpas++ = gpa;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  862  		offset = 0;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  863  		ga += fragment_len;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  864  		len -= fragment_len;
> 2293897805c2fe Heiko Carstens           2014-01-01  865  	}
> 2293897805c2fe Heiko Carstens           2014-01-01  866  	return 0;
> 2293897805c2fe Heiko Carstens           2014-01-01  867  }
> 

