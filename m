Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACB5983EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiHRNPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiHRNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:15:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9195291
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:15:31 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IDEltn021635;
        Thu, 18 Aug 2022 13:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=c327IQLV86Rb2rDJ39pulBQyI5rB9MumzWE4us67BKI=;
 b=hOoWZXina0/O517VaP26q2LZ9hJjFsw7qwqVnFERRSIKtX+np4roxMmaDpi8ZI3tYSEQ
 2FnDxYmXXt/EyB7SOXACtk44d6LN1MHu4qH2U7qBQtHjAF9a9WDGXBl5KMuHSPuEBnfg
 O3Tq8Dx55rCRHHFlVeDGGq3HXG4JXdTXFwfsjJuooMqnryd7mEkIOQ9S3+1+EmQtcP5q
 DaoIOc23SNmwxpJisuvdVgPnUKA0AD0UlH5DUry6dTnCakqma4/z/kNNgiA41MfTSg9y
 HbgyGGwvKFOSEHZD+oKt0sejaKhoZnEgzG9dXQtclnf8aJk2sOwrQow20ZNVo5Vsh+FL QA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1p50r010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:14:48 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID7AcZ027534;
        Thu, 18 Aug 2022 13:14:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3hx37j4g14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:14:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDF10232768330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:15:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81F9EA4051;
        Thu, 18 Aug 2022 13:14:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2998CA404D;
        Thu, 18 Aug 2022 13:14:42 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.25.99])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:14:42 +0000 (GMT)
Message-ID: <7ac81a33fd32dc1f4dabc8f9b478ecf3ad20d7cf.camel@linux.ibm.com>
Subject: Re: arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error:
 uninitialized symbol 'prot'.
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Aug 2022 15:14:41 +0200
In-Reply-To: <48a15fdd-8400-69d3-1a70-5680461d2146@linux.ibm.com>
References: <202208140141.4uzWszG4-lkp@intel.com>
         <f27b0f3a-5e89-1fb1-ac23-ed896ec7150f@linux.ibm.com>
         <20220817163838.5469ca53@p-imbrenda>
         <48a15fdd-8400-69d3-1a70-5680461d2146@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XZt8oHkuC3h2uHuPUojTT_4zio2IiVWM
X-Proofpoint-ORIG-GUID: XZt8oHkuC3h2uHuPUojTT_4zio2IiVWM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-18 at 09:45 +0200, Janosch Frank wrote:
> On 8/17/22 16:38, Claudio Imbrenda wrote:
> > On Wed, 17 Aug 2022 12:30:11 +0200
> > Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
> > 
> > > On 8/15/22 09:23, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
> > > > commit: 7faa543df19bf62d4583a64d3902705747f2ad29 KVM: s390: gaccess: Refactor access address range check
> > > > config: s390-randconfig-m031-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140141.4uzWszG4-lkp@intel.com/config)
> > > > compiler: s390-linux-gcc (GCC) 12.1.0
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > 
> > > > smatch warnings:
> > > > arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error: uninitialized symbol 'prot'.
> > > > 
> > > > vim +/prot +859 arch/s390/kvm/gaccess.c
> > > > 
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  831  static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  832  			       unsigned long *gpas, unsigned long len,
> > > > 92c9632119b67f David Hildenbrand        2015-11-16  833  			       const union asce asce, enum gacc_mode mode)
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  834  {
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  835  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  836  	unsigned int offset = offset_in_page(ga);
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  837  	unsigned int fragment_len;
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  838  	int lap_enabled, rc = 0;
> > > > 6ae1574c2a24ee Christian Borntraeger    2017-06-07  839  	enum prot_type prot;
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  840  	unsigned long gpa;
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  841
> > > > 75a1812230ad7a Alexander Yarygin        2015-01-22  842  	lap_enabled = low_address_protection_enabled(vcpu, asce);
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  843  	while (min(PAGE_SIZE - offset, len) > 0) {
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  844  		fragment_len = min(PAGE_SIZE - offset, len);
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  845  		ga = kvm_s390_logical_to_effective(vcpu, ga);
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  846  		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  847  			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  848  					 PROT_TYPE_LA);
> > > > a752598254016d Heiko Carstens           2017-06-03  849  		if (psw_bits(*psw).dat) {
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  850  			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  851  			if (rc < 0)
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  852  				return rc;
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  853  		} else {
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  854  			gpa = kvm_s390_real_to_abs(vcpu, ga);
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  855  			if (kvm_is_error_gpa(vcpu->kvm, gpa))
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  856  				rc = PGM_ADDRESSING;
> > > >                                                                                          ^^^^^^^^^^^^^^^^^^^^
> > > > 
> > > > "rc" set but "prot" not initialized.
> > > 
> > > prot is only used in case of PGM_PROTECTION.
> > > Because of that, we could initialize prot to an arbitrary value, but that seems misleading and a bit ugly to me.
> > > Alternatively, we could introduce a PROT_NONE.
> > > Or we do nothing, since there is no actual problem.
> > > @Janosch, @Claudio, what do you think?
> > 
> > I agree that this is not a bug.
> > 
> > It does look ugly, though, and all reasonable solutions are also ugly
> > (each for a different reason).
> > 
> > another solution is to set prot to an arbitrary value only in the if
> > case marked above. that way prot is not arbitrarily initialized, and
> > there is no need to add a new PROT_NONE (which then would need to be
> > checked for in trans_exc)
> > 
> > I do not have a strong opinion, though
> 
> We either have a prot value or terminate is set, right?

It's independent of termination, we will have a valid value for prot if
we terminate. And I guess it still would be undefined behavior even if
the value were invalid and we terminate.
> 
> So I'd opt to add a PROT_NONE (with a comment that it's only used for 
> init). If the statement above is true we can then also add a WARN if no 
> valid PROT_* is set in case if terminate isn't true and a PGM_PROTECTION 
> has been specified.

I think what I'll do is introduce PROT_NONE, but not initialize prot
with it, but set prot to NONE whenever a code other than PGM_PROTECTION
is set.
> 
> 
> > 
> > > 
> > > > 
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  857  		}
> > > > cde0dcfb5df1db David Hildenbrand        2016-05-31  858  		if (rc)
> > > > 6ae1574c2a24ee Christian Borntraeger    2017-06-07 @859  			return trans_exc(vcpu, rc, ga, ar, mode, prot);
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  860  		if (gpas)
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  861  			*gpas++ = gpa;
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  862  		offset = 0;
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  863  		ga += fragment_len;
> > > > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  864  		len -= fragment_len;
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  865  	}
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  866  	return 0;
> > > > 2293897805c2fe Heiko Carstens           2014-01-01  867  }
> > > >    
> > > 
> > 
> 

