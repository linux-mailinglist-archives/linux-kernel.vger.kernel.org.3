Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7B59719D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiHQOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbiHQOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:40:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F9712A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:39:28 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HEJvtw017836;
        Wed, 17 Aug 2022 14:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GtGdwtxeHCtaMIpyjP57lY6ndIfMIOAefiaokaG9/Fg=;
 b=Dgs6iiKZzPFx1a2UNhbkSIIgK48KIxc49fvIdGUjR9hURY0IGstBIwGHSzYhLWtbF+nx
 X/icIzbgh3KUwwhiuaUDfBKeLz9hDCqNJk/8e6SRXfI2fKlKtSbHYA+G7w20FXiHmWpu
 qAuCGXi+GJe412SCf0iPcvZH6TpyVpQg86ok+3hWiOOb+AyeJnoalskTswKMR2fVX3Wq
 9nwkA7CrKkY9Nh3xk6rhvQT59FLpQYgP+HS0iWA+O7qQnGG45DSsplKzeiUr5DzsNdSk
 VZO1cxvK1hJZ47YUvv6Tg2iV3c0ASm3NeQCV84lZeSsjAckLiAE7k1ogRlXTZ1sXFMnV +g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j120j8np9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 14:38:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HEadqg028218;
        Wed, 17 Aug 2022 14:38:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3hx3k93fbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 14:38:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HEZuIJ33423846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 14:35:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 038365204E;
        Wed, 17 Aug 2022 14:38:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.13.253])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9EB6652051;
        Wed, 17 Aug 2022 14:38:41 +0000 (GMT)
Date:   Wed, 17 Aug 2022 16:38:38 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Subject: Re: arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error:
 uninitialized symbol 'prot'.
Message-ID: <20220817163838.5469ca53@p-imbrenda>
In-Reply-To: <f27b0f3a-5e89-1fb1-ac23-ed896ec7150f@linux.ibm.com>
References: <202208140141.4uzWszG4-lkp@intel.com>
        <f27b0f3a-5e89-1fb1-ac23-ed896ec7150f@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rU1js-jorhGq9oxAj84lh4ttk8FwYySh
X-Proofpoint-GUID: rU1js-jorhGq9oxAj84lh4ttk8FwYySh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_09,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 12:30:11 +0200
Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> On 8/15/22 09:23, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
> > commit: 7faa543df19bf62d4583a64d3902705747f2ad29 KVM: s390: gaccess: Refactor access address range check
> > config: s390-randconfig-m031-20220812 (https://download.01.org/0day-ci/archive/20220814/202208140141.4uzWszG4-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > arch/s390/kvm/gaccess.c:859 guest_range_to_gpas() error: uninitialized symbol 'prot'.
> > 
> > vim +/prot +859 arch/s390/kvm/gaccess.c
> > 
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  831  static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  832  			       unsigned long *gpas, unsigned long len,
> > 92c9632119b67f David Hildenbrand        2015-11-16  833  			       const union asce asce, enum gacc_mode mode)
> > 2293897805c2fe Heiko Carstens           2014-01-01  834  {
> > 2293897805c2fe Heiko Carstens           2014-01-01  835  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  836  	unsigned int offset = offset_in_page(ga);
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  837  	unsigned int fragment_len;
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  838  	int lap_enabled, rc = 0;
> > 6ae1574c2a24ee Christian Borntraeger    2017-06-07  839  	enum prot_type prot;
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  840  	unsigned long gpa;
> > 2293897805c2fe Heiko Carstens           2014-01-01  841  
> > 75a1812230ad7a Alexander Yarygin        2015-01-22  842  	lap_enabled = low_address_protection_enabled(vcpu, asce);
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  843  	while (min(PAGE_SIZE - offset, len) > 0) {
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  844  		fragment_len = min(PAGE_SIZE - offset, len);
> > 2293897805c2fe Heiko Carstens           2014-01-01  845  		ga = kvm_s390_logical_to_effective(vcpu, ga);
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  846  		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  847  			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  848  					 PROT_TYPE_LA);
> > a752598254016d Heiko Carstens           2017-06-03  849  		if (psw_bits(*psw).dat) {
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  850  			rc = guest_translate(vcpu, ga, &gpa, asce, mode, &prot);
> > 2293897805c2fe Heiko Carstens           2014-01-01  851  			if (rc < 0)
> > 2293897805c2fe Heiko Carstens           2014-01-01  852  				return rc;
> > 2293897805c2fe Heiko Carstens           2014-01-01  853  		} else {
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  854  			gpa = kvm_s390_real_to_abs(vcpu, ga);
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  855  			if (kvm_is_error_gpa(vcpu->kvm, gpa))
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  856  				rc = PGM_ADDRESSING;
> >                                                                                         ^^^^^^^^^^^^^^^^^^^^
> > 
> > "rc" set but "prot" not initialized.  
> 
> prot is only used in case of PGM_PROTECTION.
> Because of that, we could initialize prot to an arbitrary value, but that seems misleading and a bit ugly to me.
> Alternatively, we could introduce a PROT_NONE.
> Or we do nothing, since there is no actual problem.
> @Janosch, @Claudio, what do you think?

I agree that this is not a bug.

It does look ugly, though, and all reasonable solutions are also ugly
(each for a different reason).

another solution is to set prot to an arbitrary value only in the if
case marked above. that way prot is not arbitrarily initialized, and
there is no need to add a new PROT_NONE (which then would need to be
checked for in trans_exc)

I do not have a strong opinion, though

> 
> > 
> > 2293897805c2fe Heiko Carstens           2014-01-01  857  		}
> > cde0dcfb5df1db David Hildenbrand        2016-05-31  858  		if (rc)
> > 6ae1574c2a24ee Christian Borntraeger    2017-06-07 @859  			return trans_exc(vcpu, rc, ga, ar, mode, prot);
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  860  		if (gpas)
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  861  			*gpas++ = gpa;
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  862  		offset = 0;
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  863  		ga += fragment_len;
> > 7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  864  		len -= fragment_len;
> > 2293897805c2fe Heiko Carstens           2014-01-01  865  	}
> > 2293897805c2fe Heiko Carstens           2014-01-01  866  	return 0;
> > 2293897805c2fe Heiko Carstens           2014-01-01  867  }
> >   
> 

