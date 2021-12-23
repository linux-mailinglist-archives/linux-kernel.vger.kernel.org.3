Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8747E733
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhLWRks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:40:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbhLWRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:40:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNH7a0s001651;
        Thu, 23 Dec 2021 17:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=eBmmDwkzofRz3Sq0LNHmfojyVVgiEMP+JJXGQTPyIh8=;
 b=s+nIxbWQHW5lissyZM563PDk9kmeHqYJasn215svFBLLDZDgRZrn++eXN7AlVpl5EFZI
 GQY/fePkDdfpKVQg59SGfRzpu/Dm3gn+bB9+YqTQzon+afXLF0PYjtWp+RQyYa381gG5
 i7MyRXZsX6EHk+StD7z1rNJumo49p8t9N3Vkea7G8924/4T7T++clpsqAvKRE0/+ilZ5
 QxYOKTWFKqgFuDeUvzt3ORmv4mhe8dn/FT6Ipd4Ydg0uCKNkR2yWfhC86llBKSrfaJQn
 D2EdR7kJXwdp3Y5THQOUtDbRSaWlxIwtwPHVWFPycQp4dmME2Y6gjV8/0I2LANInOSqW fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4u3p3072-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 17:40:26 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BNH8uKl007617;
        Thu, 23 Dec 2021 17:40:25 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4u3p305t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 17:40:25 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BNHNJqn010075;
        Thu, 23 Dec 2021 17:40:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3d179a6fu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 17:40:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BNHeKuB27984166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 17:40:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1CB242045;
        Thu, 23 Dec 2021 17:40:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DBB742041;
        Thu, 23 Dec 2021 17:40:20 +0000 (GMT)
Received: from osiris (unknown [9.145.187.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Dec 2021 17:40:20 +0000 (GMT)
Date:   Thu, 23 Dec 2021 18:40:18 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jerome Marchand <jmarchan@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
Message-ID: <YcS0gg35kS21Zd3i@osiris>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
 <alpine.LSU.2.21.2112230949520.19849@pobox.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2112230949520.19849@pobox.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WYy1hleae0WXmHZwu0g5vXtuabE5tAwk
X-Proofpoint-GUID: 6kKOXTTBIM7SXlilAVtiFpgI4jqgrUCr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_04,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
> > the objdump -d outpout. However since binutils 2.37, objdump -d
> > display "jgnop <xxx>" for the same instruction. Update the
> > mcount_regex so that it accepts both.
> > 
> > Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
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
> 
> there is a typo I did not notice before. Sorry about that *sigh*.
> 
> s/bcrl/brcl/ on the whole patch.

Hm.. nice. So I will schedule the patch below for next week. Actually
tested with the variants I mentioned in the commit message.

From 30b3302ae3e9fb30c4cef5c17a2a63ba6ba34195 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 23 Dec 2021 17:43:14 +0100
Subject: [PATCH] recordmcount.pl: fix typo in s390 mcount regex

Commit 85bf17b28f97 ("recordmcount.pl: look for jgnop instruction as well
as bcrl on s390") added a new alternative mnemonic for the existing brcl
instruction. This is required for the combination old gcc version (pre 9.0)
and binutils since version 2.37.
However at the same time this commit introduced a typo, replacing brcl with
bcrl. As a result no mcount locations are detected anymore with old gcc
versions (pre 9.0) and binutils before version 2.37.
Fix this by using the correct mnemonic again.

Reported-by: Miroslav Benes <mbenes@suse.cz>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: <stable@vger.kernel.org>
Fixes: 85bf17b28f97 ("recordmcount.pl: look for jgnop instruction as well as bcrl on s390")
Link: https://lore.kernel.org/r/alpine.LSU.2.21.2112230949520.19849@pobox.suse.cz
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/recordmcount.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 52a000b057a5..3ccb2c70add4 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "s390" && $bits == 64) {
     if ($cc =~ /-DCC_USING_HOTPATCH/) {
-	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
+	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(brcl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
 	$mcount_adjust = 0;
     }
     $alignment = 8;
-- 
2.32.0

