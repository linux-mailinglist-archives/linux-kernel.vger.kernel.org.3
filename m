Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AC566C67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiGEMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiGEMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0E1583E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657022848; x=1688558848;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yz2z7DHKpqQXYgWsCjGsTlHF40gAP0QftYaqtSy5ZG8=;
  b=XXNZYgib5iIZfjb1uW6lSnZVGggcyUGMShkhK9rKujYaIyZ8nIZGACV+
   YwTEgOenDFBRmamUipSHpqRDxwuiGt77V2PMfV/kkBJKCkghCqBX0FlXO
   r/VrkRt0HLA2FDTSoZ4ipBoh64I3UtBwKkBQ2Wf1+cwqAM5ioBDWaEGmq
   SX/ikXlzWuRRPIYjaDPaM8cyfnLji3Ep19FE/MpiaVreLlqy6S6+m1Ca4
   2F31p3BVqxetTEGD7wi6sjIPhRsf4fRp2iuf/HEpj/4vTgJHu4MMYgT5g
   d2MP1wPoVEIybIjkRH74oOxLxnifnQKxhUjXkUUgopkto/P4C9tK4xeJw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284448674"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="284448674"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="597276207"
Received: from atornero-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.166.122])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:07:24 -0700
Message-ID: <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Jul 2022 00:07:22 +1200
In-Reply-To: <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
         <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
         <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
         <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-30 at 16:50 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
>=20
> On 6/27/22 10:24 AM, Dave Hansen wrote:
> > On 6/27/22 07:50, Sathyanarayanan Kuppuswamy wrote:
>=20
> > > > Second, how can someone test this code?  It appears that they need =
to
> > > > assemble a veritable Rube Goldberg machine.  The least we could do =
is
> > > > have a selftest that just calls the ioctl() and makes sure that
> > > > something halfway sane comes out of it.
> > >=20
> > > My initial submission included a test app. But I removed it later to
> > > reduce the review load. I thought to submit the test app once feature
> > > support patches are merged.
> > >=20
> > > https://lore.kernel.org/all/9247fade9db5ae6eb183b2f92fdedb898282376a.=
1648664666.git.sathyanarayanan.kuppuswamy@intel.com/
> > >=20
> > > If you prefer, I can add it back to the next submission with the late=
st changes.
> >=20
> > I doubt anyone will ever run a "test app".  Why not just make this a
> > selftest?
>=20
> Fine with me. I can change it into selftest.
>=20
> >=20
> > > > > In such
> > > > > case, since REPORTDATA is a secret, using sysfs to share it is in=
secure
> > > > > compared to sending it via IOCTL.
> > > >=20
> > > > Huh?  How is sysfs "insecure"?
> > >=20
> > > REPORTDATA (input) we pass to the Module call might come from attesta=
tion
> > > service as a per session unique ID.  If it is shared via sysfs, there=
 is
> > > a possibility for untrusted software to read it and trigger some form=
 of
> > > reply attack. So in this context, sysfs is insecure compared to IOCTL
> > > approach. You can find the related discussion in,
> > >=20
> > > https://lore.kernel.org/lkml/b8eadd3079101a2cf93ee87d36dbedf93d8a2725=
.camel@intel.com/
> >=20
> > I still don't get it.
> >=20
> > How is a 400 sysfs file "insecure"?  This sounds "if the filesystem
> > permissions are broken" paranoia.  In other words, you're protecting
> > against a malicious root user.
>=20
> AFAIK, root is not the only user of the attestation interface. General us=
ers can
> also use it (For example, in a use case like pytorch, attestation may be =
requested
> by server before passing the training data). So if the permission is not =
"root
> only", then other users or application in TD can access the sysfs file to=
 read
> its contents.=20
>=20
> Also, the security concern mentioned is just an additional point. Followi=
ng are
> the main reasons for choosing IOCTL over sysfs.
>=20
> 1. Sysfs is generally used for config purposes. Not for request/response =
kind of
>    use case (Attestation falls under this category).
> 2. If we only use sysfs model for GetReport, the design might look like b=
elow:=20
>=20
>     /sys/kernel/../report/input
>     /sys/kernel/../report/subtype
>     /sys/kernel/../report/input_len
>     /sys/kernel/../report/output
>     /sys/kernel/../report/output_len
>     /sys/kernel/../report/status
>     /sys/kernel/../report/trigger

I don't think you need all those if using /sysfs approach.  You only need
'reportdata' and 'tdreport' to start with (see below my old reply). =C2=A0

	echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
	cat /sys/kernel/coco/tdx/attest/tdreport

	Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver
	to call TDCALL to get the TDREPORT, which is available at=C2=A0
	'/sys/.../tdreport'.

You can add more (such as subtype) in the future if needed (and I doubt it =
will
ever happen) but this doesn't break any existing ABI.  'output/output_len' =
also
not needed, kernel can return the report with right size.

Btw, although the /sysfs may not be as secure as IOCTL -- as you mentioned
above, other programs with the same permission can get the TD report by rea=
ding
/sysfs and use it as a "reply attack" -- but I am not sure whether such
"potential reply attack" is a true issue or not.  For instance, typically t=
he
attestation service should already have established a secure TLS connection=
 with
TD attestation agent before it provides the 'nonce' (reportdata), and the
attestation should reject the TD report from other connection, etc.

>=20
> We might need similar files for GetQuote use case as well. IMO, such a de=
sign is=20
> more complicated than using IOCTL.

Using /sysfs for TD report doesn't necessarily mean you must use /sysfs for
Quote.  I don't think we should mixing them up.  For instance, even if we u=
se
/dev/xxx for getting TD report, we can use a separate device node for getti=
ng
the Quote:

	/dev/tdreport
	/dev/tdquote

I believe there should be pros/cons comparing to using single /dev/attest, =
but I
haven't thought this very carefully.


> >=20
> > In other words, I don't think the ABI here has been well thought out.
> >=20
> > Also, this is basically a:
> >=20
> > 	Inputs:
> >=20
> > 		* nonce
> > 		* report type
> >=20
> > 	Outputs:
> >=20
> > 		* report
> >=20
> > I have to wonder how hard it would be to have this be:
> >=20
> > 	fd =3D open("/dev/foo");
> > 	ioctl(fd, REPORT, type, flags??);
> > 	write(fd, &inputs, inputs_len);
> > 	read(fd,  &output, outputs_len);

It looks like the kernel and userspace still need data structures to agree =
on
the input/output data format.  I guess with this approach, we can start wit=
h
what we need now, and if we need more in the future, we define new data
structures for input and output?

> >=20
>=20
> It is not hard to implement it this way. But I don't see it being
> very different from just using IOCTL. config/{read/write} model is
> usually preferred for applications in which you have a requirement to do
> multiple read/writes after one time config (use cases like serial
> port read, printer write or reading temperature, etc). But in our case
> we will mostly use it once after every config.=20
>=20
> Also, splitting input over IOCTL and write system call will require us
> to add additional code to store the state.
>=20
> I have attempted a sample implementation (untested) for reference. But I
> feel our current code is simpler. It handles allocation and input/output
> validation in one place compared to spreading it across multiple handlers=
.=20
>=20
> struct report_req {
>         int subtype;
>         void *reportdata;
>         int reportdata_len;
> };
>=20
> struct tdx_attest_req {
>         unsigned int cmd;
>         void *data;
> };

Is it supposed to be used for Quote too?

I dislike the idea of mixing up getting TD report and getting Quote (make T=
D
report and Quote both as a sub-commands, etc).

As we have adequately put, the new IOCTLs to support getting Quote isn't ev=
en
mandatory -- we just need some communication channel between TD attestation
agent and the QE, such as vsock.

>=20
>=20
> static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>                              unsigned long arg)
> {
>         void __user *argp =3D (void __user *)arg;
>         struct tdx_attest_req *areq =3D file->private_data;
>         struct report_req *rep_data =3D NULL;
>         struct tdx_report_req user_req;
>         long ret =3D -EINVAL;
>=20
>         switch (cmd) {
>         case TDX_CMD_GET_REPORT:
>                 /* Allocate space for TDREPORT request */
>                 rep_data =3D kmalloc(sizeof(struct report_req), GFP_KERNE=
L);
>                 if (!rep_data)
>                         return -ENOMEM;
>=20
>                 /* Copy user request data */
>                 if (copy_from_user(&user_req, argp, sizeof(user_req))) {
>                         kfree(rep_data);
>                         return -EFAULT;
>                 }
>=20
>                 /* Copy user request details to areq->data */
>                 rep_data->subtype =3D user_req.subtype;
>                 areq->cmd =3D cmd;
>                 areq->data =3D rep_data;
>=20
>                 ret =3D 0;
>                 break;
>         default:
>                 pr_debug("cmd %d not supported\n", cmd);
>                 break;
>         }
>=20
>         return ret;
> }
>=20
> static ssize_t tdx_attest_read(struct file *filp, char __user *buffer,
>                                 size_t length, loff_t *offset)
> {
>         struct tdx_attest_req *areq =3D filp->private_data;
>         struct report_req *rep_data;
>         void *tdreport;
>         long ret;
>=20
>         if (!areq)
>                 return -EINVAL;
>=20
>         switch (areq->cmd) {
>         case TDX_CMD_GET_REPORT:
>=20
>                 /* Check for valid length and offset */
>                 if (length !=3D TDX_REPORT_LEN || offset !=3D 0)
>                         return -EINVAL;
>=20
>                 rep_data =3D areq->data;
>=20
>                 /* Make sure we have valid reportdata */
>                 if (!rep_data->reportdata)
>                         return -EINVAL;
>=20
>                 /* Allocate space for output data */
>                 tdreport =3D kzalloc(length, GFP_KERNEL);
>                 if (!tdreport)
>                         return -ENOMEM;
>                 /*
>                  * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
>                  *
>                  * Get the TDREPORT using REPORTDATA as input. Refer to
>                  * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.=
0
>                  * Specification for detailed information.
>                  */
>                 ret =3D __tdx_module_call(TDX_GET_REPORT, virt_to_phys(td=
report),
>                                 virt_to_phys(rep_data->reportdata), 0, 0,=
 NULL);
>                 if (ret) {
>                         pr_debug("TDREPORT TDCALL failed, status:%lx\n", =
ret);
>                        kfree(tdreport);
>                         return -EIO;
>                 }
>=20
>                 /* Copy REPORTDATA from the user buffer */
>                 if (copy_to_user(buffer, tdreport, length)) {
>                         kfree(tdreport);
>                         return -EFAULT;
>                 }
>=20
>                 return length;
>         default:
>                 pr_debug("cmd %d not supported\n", areq->cmd);
>                 break;
>         }
>=20
>         return 0;
> }
>=20
> static ssize_t tdx_attest_write(struct file *filp, const char __user *buf=
fer,
>                                 size_t length, loff_t *offset)
> {
>         struct tdx_attest_req *areq =3D filp->private_data;
>         struct report_req *rep_data;
>=20
>         if (!areq)
>                 return -EINVAL;
>=20
>         switch (areq->cmd) {
>         case TDX_CMD_GET_REPORT:
>=20
>                 /* Check for valid length and offset */
>                 if (length !=3D TDX_REPORTDATA_LEN || offset !=3D 0)
>                         return -EINVAL;
>=20
>                 rep_data =3D areq->data;
>=20
>                 /* Allocate space to store REPORTDATA */
>                 rep_data->reportdata =3D kzalloc(length, GFP_KERNEL);
>                 if (!rep_data->reportdata)
>                         return -ENOMEM;
>=20
>                 /* Copy REPORTDATA from the user buffer */
>                 if (copy_from_user(rep_data->reportdata, buffer, length))=
 {
>                         kfree(rep_data->reportdata);
>                         rep_data->reportdata =3D NULL;
>                         return -EFAULT;
>                 }
>=20
>                 rep_data->reportdata_len =3D length;
>=20
>                 return length;
>         default:
>                 pr_debug("cmd %d not supported\n", areq->cmd);
>                 break;
>         }
>=20
>         return 0;
> }
>=20
>=20
> static int tdx_attest_open(struct inode *inode, struct file *filp)
> {
>         struct tdx_attest_req *areq;
>=20
>         /* Allocate space to track attestation request */
>         areq =3D kmalloc(sizeof(*areq), GFP_KERNEL);
>         if (!areq)
>                 return -ENOMEM;
>=20
>         filp->private_data =3D areq;
>=20
>         return 0;
> }
>=20
> static int tdx_attest_release(struct inode *inode, struct file *filp)
> {
>         kfree(filp->private_data);
>         filp->private_data =3D NULL;
>=20
>         return 0;
> }
>=20
> static const struct file_operations tdx_attest_fops =3D {
>         .owner          =3D THIS_MODULE,
>         .open           =3D tdx_attest_open,
>         .read           =3D tdx_attest_read,
>         .write          =3D tdx_attest_write,
>         .unlocked_ioctl =3D tdx_attest_ioctl,
>         .release        =3D tdx_attest_release,
>         .llseek         =3D no_llseek,
> };
>=20
> > > > How many of these "drivers" are we going to need which are thinly v=
eiled
> > > > ioctl()s that are only TDX module call wrappers?
> >=20
> > This is actually a really big question.  This code is obviously just
> > trying to do one thing very narrowly and not thinking about the future
> > at all.  Can we please consider what the future will be like and try to
> > *architect* this instead of having the kernel just play a glorified gam=
e
> > of telephone?
>=20
> I am not very clear about other possible use cases.=20
>=20
> Kirill/Kai/Isaku, Do you think we might need similar infrastructure for a=
ny
> other TDX Module calls or TDVMCALLs?
>=20
>=20

So far only attestation related TDCALL and TDVMCALL requires interaction to
userspace.

For attestation, conceptually, we need two "sets" of ABIs: 1) around gettin=
g the
TD report; 2) around getting the Quote.

For 1) we are discussing above.=20

For 2), currently we have only GetQuote TDVMCALL.  It's very possible we wi=
ll
need more sub-commands around Quote (not only get the Quote) -- logically, =
Quote
generation service defines Quote related commands anyway. =C2=A0

Theoretically, we only need one TDVMCALL (or a fixed set of TDVMCALLs) for
sending/receiving data as a communication channel (as an alternative to vso=
ck,
etc) to support any Quote related sub-commands, but it seems we are not hea=
ding
that way.

--=20
Thanks,
-Kai


