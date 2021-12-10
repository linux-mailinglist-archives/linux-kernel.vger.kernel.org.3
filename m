Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DCB46FF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbhLJLCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:02:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233200AbhLJLCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:02:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAASTJf028514;
        Fri, 10 Dec 2021 10:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=i8ybgvvgYKBNtz1P3utuouyYny8AuTKZJBCKDeu+aQw=;
 b=nRiaywFHOiyswiiVkJKzKY7/mfaoInB2XSZymI0ia7he92adv4+PSzK3AId12zNGOANF
 LZ92gmOpAp+pjMKijdh9faBWlNEKo+fK+UO298CklxnTb8bQhYAN2RplOsVP61mFZNU/
 2rM184Y4PQYEmg8wyFR2Fc0oHD+Pmix9Yr4Q3wehVfEMtFpDy3J1PzqWuckhcjVx3a0M
 +aLtIZYpG2F6/Ldwp5tgjyc1P7J585Hsj3z8c30tzSTm5sbaqN7hivcYb7PmZY7YV1Rc
 eXBu63L6bCcJqLW2cQANKz/kc+NbPwo4HxSCbtL8mOZk5gU+cxrtW0o0dNUSIVU060EO Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv55yrf6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 10:58:13 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAArU0m011557;
        Fri, 10 Dec 2021 10:58:13 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv55yrf5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 10:58:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAAw6HU031687;
        Fri, 10 Dec 2021 10:58:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3cqyyafvqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 10:58:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAAw6Zt24379706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 10:58:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50D4752059;
        Fri, 10 Dec 2021 10:58:06 +0000 (GMT)
Received: from osiris (unknown [9.145.166.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0E01452054;
        Fri, 10 Dec 2021 10:58:06 +0000 (GMT)
Date:   Fri, 10 Dec 2021 11:58:04 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jerome Marchand <jmarchan@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
Message-ID: <YbMyvJ6gz7LvoXgE@osiris>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
 <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Whe56XRE_EiiY47H96_9fv-kQMNjl-Z
X-Proofpoint-ORIG-GUID: vNjG7mZPYPUs4ECgEPx9OxuIgHVSL8hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:57:00AM +0100, Miroslav Benes wrote:
> On Fri, 10 Dec 2021, Jerome Marchand wrote:
> 
> > On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
> > the objdump -d outpout. However since binutils 2.37, objdump -d
> > display "jgnop <xxx>" for the same instruction. Update the
> > mcount_regex so that it accepts both.
> > 
> > Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> 
> Yes, we ran into exactly this issue too...
> 
> > ---
> >  scripts/recordmcount.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > index 7d631aaa0ae1..52a000b057a5 100755
> > --- a/scripts/recordmcount.pl
> > +++ b/scripts/recordmcount.pl
> > @@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
> >  
> >  } elsif ($arch eq "s390" && $bits == 64) {
> >      if ($cc =~ /-DCC_USING_HOTPATCH/) {
> > -	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
> > +	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
> >  	$mcount_adjust = 0;
> >      }
> >      $alignment = 8;
> 
> ...and we have exactly the same fix in SLES. I haven't got to submit it 
> to upstream yet :(, many thanks for doing it.
> 
> So at least
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Just out of curiosity: am I right if I assume that both of you have
kernel sources without upstream commit
d983c89cc96a ("s390/ftrace: Add -mfentry and -mnop-mcount support")
and the commits directly preceding that one?

Otherwise I would be surprised that this would make any difference.

Applied to s390 tree + added a stable tag.

Thank you!
