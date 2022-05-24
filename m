Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7835F532856
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiEXKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiEXKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:54:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BC6D4DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:54:51 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OADOaM015706;
        Tue, 24 May 2022 10:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Nrxgom3MLX6g50vXoEm8BIU2OPvNwgy5HT+9UXUTXg0=;
 b=lCxduZVsfaFjYR0TKJxBjWyyIYDe9tN5SjeE3KpNdYtsm/QAR5KjzriLtDtsVknhv8xz
 3d/lQPt8OHiLcwmdzRe4AkC5XZlGyGAnluEgJF5y4L9eQEJfiXj6Eyp+tPu0kdMjADlI
 WrpRa+SYfoTZWCXQwBwSnXZud2Z2/rEmEyyVz7gHJg6fF06ygHgSCf9COMLbO40MBxRC
 9dDw9//5P51zxGqwGFPBR/tiS4cKgPQTdbUTiNyylS65YTpTfRlDPI+bvcW0BBYiJPsz
 qQlUXH/KbQX/VdwHa5K8GHhe6HZlFfMc6NwQojXsBpsmKVn2YBBqClxSB0yjIsB75AQn yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8wdwgqa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:54:04 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OApVEa006456;
        Tue, 24 May 2022 10:54:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8wdwgq9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:54:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OAmC8O004605;
        Tue, 24 May 2022 10:54:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3g6qbjca82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 10:54:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OArxDw26935622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 10:53:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20BBE4203F;
        Tue, 24 May 2022 10:53:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B03E142041;
        Tue, 24 May 2022 10:53:56 +0000 (GMT)
Received: from [9.109.198.201] (unknown [9.109.198.201])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 10:53:56 +0000 (GMT)
Message-ID: <d28a9bf0-65ac-797c-3640-8af7e0beec33@linux.vnet.ibm.com>
Date:   Tue, 24 May 2022 16:23:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 2/4] objtool: Enable objtool to run only on files with
 ftrace enabled
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20220523175548.922671-1-sv@linux.ibm.com>
 <20220523175548.922671-3-sv@linux.ibm.com>
 <89012c4c-e989-6092-d4f1-0dc4eca983f1@csgroup.eu>
From:   Sathvika Vasireddy <sv@linux.vnet.ibm.com>
In-Reply-To: <89012c4c-e989-6092-d4f1-0dc4eca983f1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AVhW1Dc3cEWdid4W_p3zdx0JILhb6MtW
X-Proofpoint-ORIG-GUID: D9UunNa4rSX1eYO6WDOYT3CR6rkBFg7u
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_06,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240053
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 24/05/22 14:27, Christophe Leroy wrote:
>
> Le 23/05/2022 à 19:55, Sathvika Vasireddy a écrit :
>> This patch makes sure objtool runs only on the object files
>> that have ftrace enabled, instead of running on all the object
>> files.
> Why do that ?
This was done to address the issue discussed here:
https://lore.kernel.org/all/b06bb9bc-22d1-acce-fe68-c7c4cb7c15b5@csgroup.eu/ 

>
> What about static_calls ? There may be files without ftrace but with
> static calls.
Yes, this prevents objtool from running on those files. We can
restrict this change to FTRACE_MCOUNT_USE_OBJTOOL
>
> By the way, it would be nice if we could use it only on C files.
> I get the following errors for ASM files:
>
> arch/powerpc/kernel/entry_32.o: warning: objtool: .text+0x1b4:
> unannotated intra-function call

I'm looking into ways to address this.

- Sathvika

