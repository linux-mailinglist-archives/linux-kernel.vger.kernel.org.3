Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F354CA9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbiCBQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbiCBQS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:18:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14914090
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:17:42 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222GE75R014923;
        Wed, 2 Mar 2022 16:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZJ5K7iFj8VA2bByJ9rhezKrjkKC+GQ1PyADOaQvthrU=;
 b=L5XAPmmj+t1+awWUpUrMN0S+79braRakNVJhlZmVi0qtapkqvs3T/CyY4bElifr5OsZr
 xwv9f2iA15ZCHhwGWqxCHfy43noutiiPmP0MFd+NhlOYzrPcOqi+EbyacRL45hFGrwFx
 4Itu+Fc0NGw5GGZbuLUjja/v1pNnLU8xlwTRskpvS0pJhD5VCI9E6dQR+jnSy20GJXgf
 dlgityXj8IXMmfhPTeW20ovHiIpW10rvAgcu8xaRmB6dsXHmDaOS2GbYgSO2fUYsJ3c7
 VLEJgJ4st1wG4m+auiMFc7OBZb0IEods5NQWtDqw2AqnlQRyyBPL9u/nbmoaYxU0yXWr RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9ssbjyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:17:12 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222Fxu7v026962;
        Wed, 2 Mar 2022 16:17:12 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej9ssbjxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:17:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222GD79S014007;
        Wed, 2 Mar 2022 16:17:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3efbu9dsyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:17:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222G6AeT50201042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 16:06:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5609E4C058;
        Wed,  2 Mar 2022 16:17:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFE34C040;
        Wed,  2 Mar 2022 16:17:05 +0000 (GMT)
Received: from localhost (unknown [9.43.109.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 16:17:05 +0000 (GMT)
Date:   Wed, 02 Mar 2022 21:47:03 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
        <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
        <20220301191245.GI11184@worktop.programming.kicks-ass.net>
        <20220301200547.GK11184@worktop.programming.kicks-ass.net>
In-Reply-To: <20220301200547.GK11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646236764.vx04n8yp12.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Udb1YxetWy9oaGbW7DaARIqVVGxAwSua
X-Proofpoint-ORIG-GUID: rILndznaQ9w4YOVvJS5LkWM8pqlUQY0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -105,6 +105,27 @@ kprobe_opcode_t *kprobe_lookup_name(cons
>  	return addr;
>  }
>=20
> +static bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +#ifdef PPC64_ELF_ABI_v2
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	return offset <=3D 16;
> +#else
> +	return offset <=3D 8;
> +#endif
> +#else
> +	return !offset;
> +#endif
> +}
> +
> +/* XXX try and fold the magic of kprobe_lookup_name() in this */
> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned lo=
ng offset,
> +					 bool *on_func_entry)
> +{
> +	*on_func_entry =3D arch_kprobe_on_func_entry(offset);
> +	return (kprobe_opcode_t *)(addr + offset);
> +}
> +

With respect to kprobe_lookup_name(), one of the primary motivations there =
was=20
the issue with function descriptors for the previous elf v1 ABI (it likely =
also=20
affects ia64/parisc). I'm thinking it'll be simpler if we have a way to obt=
ain=20
function entry point. Something like this:

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 4176c7eca7b5aa..8c57cc5b77f9ae 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -73,6 +73,12 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char=
 *, struct module *,
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
=20
+/* Return function entry point by additionally dereferencing function desc=
riptor */
+static inline unsigned long kallsyms_lookup_function(const char *name)
+{
+	return (unsigned long)dereference_symbol_descriptor((void *)kallsyms_look=
up_name(name));
+}
+
 extern int kallsyms_lookup_size_offset(unsigned long addr,
 				  unsigned long *symbolsize,
 				  unsigned long *offset);
@@ -103,6 +109,11 @@ static inline unsigned long kallsyms_lookup_name(const=
 char *name)
 	return 0;
 }
=20
+static inline unsigned long kallsyms_lookup_function(const char *name)
+{
+	return 0;
+}
+
 static inline int kallsyms_lookup_size_offset(unsigned long addr,
 					      unsigned long *symbolsize,
 					      unsigned long *offset)


With that, we can fold some of the code from kprobe_lookup_name() into=20
arch_adjust_kprobe_addr() and remove kprobe_lookup_name(). This should also=
=20
address Masami's concerns with powerpc promoting all probes at function ent=
ry=20
into a probe at the ftrace location.


- Naveen


---
 arch/powerpc/kernel/kprobes.c | 70 +++--------------------------------
 include/linux/kprobes.h       |  1 -
 kernel/kprobes.c              | 19 ++--------
 kernel/trace/trace_kprobe.c   |  2 +-
 4 files changed, 9 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7dae0b01abfbd6..46aa2b9e44c27c 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -41,70 +41,6 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 		 addr < (unsigned long)__head_end);
 }
=20
-kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
-{
-	kprobe_opcode_t *addr =3D NULL;
-
-#ifdef PPC64_ELF_ABI_v2
-	/* PPC64 ABIv2 needs local entry point */
-	addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(name);
-	if (addr && !offset) {
-#ifdef CONFIG_KPROBES_ON_FTRACE
-		unsigned long faddr;
-		/*
-		 * Per livepatch.h, ftrace location is always within the first
-		 * 16 bytes of a function on powerpc with -mprofile-kernel.
-		 */
-		faddr =3D ftrace_location_range((unsigned long)addr,
-					      (unsigned long)addr + 16);
-		if (faddr)
-			addr =3D (kprobe_opcode_t *)faddr;
-		else
-#endif
-			addr =3D (kprobe_opcode_t *)ppc_function_entry(addr);
-	}
-#elif defined(PPC64_ELF_ABI_v1)
-	/*
-	 * 64bit powerpc ABIv1 uses function descriptors:
-	 * - Check for the dot variant of the symbol first.
-	 * - If that fails, try looking up the symbol provided.
-	 *
-	 * This ensures we always get to the actual symbol and not
-	 * the descriptor.
-	 *
-	 * Also handle <module:symbol> format.
-	 */
-	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
-	bool dot_appended =3D false;
-	const char *c;
-	ssize_t ret =3D 0;
-	int len =3D 0;
-
-	if ((c =3D strnchr(name, MODULE_NAME_LEN, ':')) !=3D NULL) {
-		c++;
-		len =3D c - name;
-		memcpy(dot_name, name, len);
-	} else
-		c =3D name;
-
-	if (*c !=3D '\0' && *c !=3D '.') {
-		dot_name[len++] =3D '.';
-		dot_appended =3D true;
-	}
-	ret =3D strscpy(dot_name + len, c, KSYM_NAME_LEN);
-	if (ret > 0)
-		addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
-
-	/* Fallback to the original non-dot symbol lookup */
-	if (!addr && dot_appended)
-		addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(name);
-#else
-	addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(name);
-#endif
-
-	return addr;
-}
-
 static bool arch_kprobe_on_func_entry(unsigned long offset)
 {
 #ifdef PPC64_ELF_ABI_v2
@@ -118,11 +54,15 @@ static bool arch_kprobe_on_func_entry(unsigned long of=
fset)
 #endif
 }
=20
-/* XXX try and fold the magic of kprobe_lookup_name() in this */
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long=
 offset,
 					 bool *on_func_entry)
 {
 	*on_func_entry =3D arch_kprobe_on_func_entry(offset);
+#ifdef PPC64_ELF_ABI_v2
+	/* Promote probes on the GEP to the LEP */
+	if (!offset)
+		addr =3D ppc_function_entry((void *)addr);
+#endif
 	return (kprobe_opcode_t *)(addr + offset);
 }
=20
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9c28f7a0ef4268..dad375056ba049 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -382,7 +382,6 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(v=
oid)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
=20
-kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)=
;
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long=
 offset, bool *on_func_entry);
=20
 int register_kprobe(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8be57fdc19bdc0..066fa644e9dfa3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -67,12 +67,6 @@ static bool kprobes_all_disarmed;
 static DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
=20
-kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
-					unsigned int __unused)
-{
-	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
-}
-
 /*
  * Blacklist -- list of 'struct kprobe_blacklist_entry' to store info wher=
e
  * kprobes can not probe.
@@ -1481,7 +1475,7 @@ bool within_kprobe_blacklist(unsigned long addr)
 		if (!p)
 			return false;
 		*p =3D '\0';
-		addr =3D (unsigned long)kprobe_lookup_name(symname, 0);
+		addr =3D kallsyms_lookup_function(symname);
 		if (addr)
 			return __within_kprobe_blacklist(addr);
 	}
@@ -1524,14 +1518,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symb=
ol_name,
 		goto invalid;
=20
 	if (symbol_name) {
-		/*
-		 * Input: @sym + @offset
-		 * Output: @addr + @offset
-		 *
-		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
-		 *       argument into it's output!
-		 */
-		addr =3D kprobe_lookup_name(symbol_name, offset);
+		addr =3D (kprobe_opcode_t *)kallsyms_lookup_function(symbol_name);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
@@ -2621,7 +2608,7 @@ static int __init init_kprobes(void)
 		/* lookup the function address from its name */
 		for (i =3D 0; kretprobe_blacklist[i].name !=3D NULL; i++) {
 			kretprobe_blacklist[i].addr =3D
-				kprobe_lookup_name(kretprobe_blacklist[i].name, 0);
+				(void *)kallsyms_lookup_function(kretprobe_blacklist[i].name);
 			if (!kretprobe_blacklist[i].addr)
 				pr_err("Failed to lookup symbol '%s' for kretprobe blacklist. Maybe th=
e target function is removed or renamed.\n",
 				       kretprobe_blacklist[i].name);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 508f14af4f2c7e..a8d01954051e60 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -461,7 +461,7 @@ static bool within_notrace_func(struct trace_kprobe *tk=
)
 		if (!p)
 			return true;
 		*p =3D '\0';
-		addr =3D (unsigned long)kprobe_lookup_name(symname, 0);
+		addr =3D kallsyms_lookup_function(symname);
 		if (addr)
 			return __within_notrace_func(addr);
 	}
--=20
2.35.1


