Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FA50676E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350290AbiDSJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiDSJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913C6586
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:06:10 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23J8k1C9020338;
        Tue, 19 Apr 2022 09:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kny/t6DILsyi2qAi0gRWd149xIh/tOmS7sHh2J3UarQ=;
 b=abOur7MgvkR7eq4RnfIu+xbDFwcoJk/XUGB+Jm08GYWTrS9IbLKHB8VwjuOrPjlS5fHK
 qH/53u1u4WMHwPY9f5cbTLJp+XwmcNeZhedw+D2nMH7B7nh3cObXvaJ444idua2TRj1W
 pbaeXhetYPskK78u9hSemgul0phSBq+XGAB+pWDEfRrUogsKMZBucWc+1VO8APP72QUF
 Is6Bvegxoq//9i0d/N/y+/tyaq/YEB84NidR/5bKOLA3OL884p8jb2LL6VLN6IdpK3Nn
 CBB12Nwcsd4uGShIQPWq7S8IkZcF6v5c1E6Aqkk9IizYcdwyjuchwzu6NNbme7ruE01a Dg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7bt2kcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 09:05:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23J931D7006461;
        Tue, 19 Apr 2022 09:05:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fgu6u1pyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 09:05:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23J95pjX49611214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 09:05:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3204204B;
        Tue, 19 Apr 2022 09:05:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 044594204D;
        Tue, 19 Apr 2022 09:05:51 +0000 (GMT)
Received: from [9.171.6.77] (unknown [9.171.6.77])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Apr 2022 09:05:50 +0000 (GMT)
Message-ID: <a9c07e21-7df4-3008-d07e-d946f7f16540@linux.ibm.com>
Date:   Tue, 19 Apr 2022 11:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error:
 uninitialized symbol 'prot'.
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <202204151626.pDKgwv97-lkp@intel.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <202204151626.pDKgwv97-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3yiDAWRN2S_H8otHwWhPrzTR7Y2PFoXA
X-Proofpoint-GUID: 3yiDAWRN2S_H8otHwWhPrzTR7Y2PFoXA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190051
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 11:30, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
> commit: e613d83454d7da1c37d78edb278db9c20afb21a2 KVM: s390: Honor storage keys when accessing guest memory
> config: s390-randconfig-m031-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151626.pDKgwv97-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error: uninitialized symbol 'prot'.
> 
> Old smatch warnings:
> arch/s390/kvm/gaccess.c:935 guest_range_to_gpas() error: uninitialized symbol 'prot'.
> 
> vim +/prot +1064 arch/s390/kvm/gaccess.c
> 
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   997  int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   998  			  void *data, unsigned long len, enum gacc_mode mode,
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   999  			  u8 access_key)
> 2293897805c2fe Heiko Carstens           2014-01-01  1000  {
> 2293897805c2fe Heiko Carstens           2014-01-01  1001  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1002  	unsigned long nr_pages, idx;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1003  	unsigned long gpa_array[2];
> 416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1004  	unsigned int fragment_len;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1005  	unsigned long *gpas;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1006  	enum prot_type prot;
> 
> Maybe set "prot" to a default value?> 
> 8a242234b4bfed Heiko Carstens           2014-01-10  1007  	int need_ipte_lock;
> 8a242234b4bfed Heiko Carstens           2014-01-10  1008  	union asce asce;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1009  	bool try_storage_prot_override;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1010  	bool try_fetch_prot_override;
> 2293897805c2fe Heiko Carstens           2014-01-01  1011  	int rc;
> 2293897805c2fe Heiko Carstens           2014-01-01  1012  
> 2293897805c2fe Heiko Carstens           2014-01-01  1013  	if (!len)
> 2293897805c2fe Heiko Carstens           2014-01-01  1014  		return 0;
> 6167375b558196 David Hildenbrand        2016-05-31  1015  	ga = kvm_s390_logical_to_effective(vcpu, ga);
> 6167375b558196 David Hildenbrand        2016-05-31  1016  	rc = get_vcpu_asce(vcpu, &asce, ga, ar, mode);
> 664b4973537068 Alexander Yarygin        2015-03-09  1017  	if (rc)
> 664b4973537068 Alexander Yarygin        2015-03-09  1018  		return rc;
> 2293897805c2fe Heiko Carstens           2014-01-01  1019  	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1020  	gpas = gpa_array;
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1021  	if (nr_pages > ARRAY_SIZE(gpa_array))
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1022  		gpas = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1023  	if (!gpas)
> 2293897805c2fe Heiko Carstens           2014-01-01  1024  		return -ENOMEM;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1025  	try_fetch_prot_override = fetch_prot_override_applicable(vcpu, mode, asce);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1026  	try_storage_prot_override = storage_prot_override_applicable(vcpu);
> a752598254016d Heiko Carstens           2017-06-03  1027  	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
> 8a242234b4bfed Heiko Carstens           2014-01-10  1028  	if (need_ipte_lock)
> 8a242234b4bfed Heiko Carstens           2014-01-10  1029  		ipte_lock(vcpu);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1030  	/*
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1031  	 * Since we do the access further down ultimately via a move instruction
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1032  	 * that does key checking and returns an error in case of a protection
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1033  	 * violation, we don't need to do the check during address translation.
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1034  	 * Skip it by passing access key 0, which matches any storage key,
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1035  	 * obviating the need for any further checks. As a result the check is
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1036  	 * handled entirely in hardware on access, we only need to take care to
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1037  	 * forego key protection checking if fetch protection override applies or
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1038  	 * retry with the special key 9 in case of storage protection override.
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1039  	 */
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1040  	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode, 0);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1041  	if (rc)
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1042  		goto out_unlock;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1043  	for (idx = 0; idx < nr_pages; idx++) {
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1044  		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1045  		if (try_fetch_prot_override && fetch_prot_override_applies(ga, fragment_len)) {
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1046  			rc = access_guest_page(vcpu->kvm, mode, gpas[idx],
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1047  					       data, fragment_len);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1048  		} else {
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1049  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1050  							data, fragment_len, access_key);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1051  		}
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1052  		if (rc == PGM_PROTECTION && try_storage_prot_override)
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1053  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1054  							data, fragment_len, PAGE_SPO_ACC);
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1055  		if (rc == PGM_PROTECTION)
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1056  			prot = PROT_TYPE_KEYC;
> 
> Is PGM_PROTECTION the only positive value that "rc" can be?

No, PGM_ADDRESSING is also possible.
> 
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1057  		if (rc)
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1058  			break;
> 416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1059  		len -= fragment_len;
> 416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1060  		data += fragment_len;
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1061  		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
> 2293897805c2fe Heiko Carstens           2014-01-01  1062  	}
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1063  	if (rc > 0)
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11 @1064  		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);
> 
> Smatch is not using the cross function DB here so it assumes other
> positive values are possible.  Also "prot" might not be used in the
> trans_exc() but smatch will still complain instead of checking for
> that.

Indeed, prot is only access by trans_exc in case of PGM_PROTECTION.
That also makes a default value questionable/confusing.
> 
> 
> e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1065  out_unlock:
> 8a242234b4bfed Heiko Carstens           2014-01-10  1066  	if (need_ipte_lock)
> 8a242234b4bfed Heiko Carstens           2014-01-10  1067  		ipte_unlock(vcpu);
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1068  	if (nr_pages > ARRAY_SIZE(gpa_array))
> 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1069  		vfree(gpas);
> 2293897805c2fe Heiko Carstens           2014-01-01  1070  	return rc;
> 2293897805c2fe Heiko Carstens           2014-01-01  1071  }
> 

