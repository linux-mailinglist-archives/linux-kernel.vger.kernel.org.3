Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04C4F9176
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiDHJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiDHJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D6120D8C;
        Fri,  8 Apr 2022 02:08:40 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1RIK5atmmTlG18EgAxXyYhedI6IX65ixtlUK9V6VLk=;
        b=MDTkIZeGPCatcJ3/wmckWIt/eku0m18oTnaqoW4zpog4VqJFGZfk4U+exWlPImbUbApvFC
        KiZtwDNn+XGWDX8Mxjv5WiFt8+tLDEMFOYjZHff18+f5Zr5gel5PIIXUmpK+rN5Xw0DTur
        OLEnsTnIeBfE9redlo0zibIFEvB9ZbW70BIiDIu9FEK7glCYN0pnqYBMdnLJJ9SDoHRfDz
        4k4JAksxsfW86M72LRYDy6UB1Si46mfuZE7hH198QoqwE6yjwTw6/6T+NASim9kEdzJH9+
        IFk4/NtlT5JpwUtl+ZPDMg/WjZXnez8zMmBP4G/NygYhTAB8PBUe47ZUS7/DTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1RIK5atmmTlG18EgAxXyYhedI6IX65ixtlUK9V6VLk=;
        b=ixZw1gqbwQVL4FEdCqfOMHSYdx2nsN464D5apbd9AjFrHQ/WB6hJCPxecyYQkMmSQVFp/+
        28cslz2mew9U7sCw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Add support to get extended report
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-46-brijesh.singh@amd.com>
References: <20220307213356.2797205-46-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940891752.389.13944302064579335785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d80b494f712317493d464a55652698c4d1b7bb0f
Gitweb:        https://git.kernel.org/tip/d80b494f712317493d464a55652698c4d1b7bb0f
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Mon, 07 Mar 2022 15:33:55 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:12 +02:00

virt: sevguest: Add support to get extended report

Version 2 of GHCB specification defines Non-Automatic-Exit (NAE) to get
extended guest report which is similar to the SNP_GET_REPORT ioctl. The
main difference is related to the additional data that will be returned.

That additional data returned is a certificate blob that can be used by
the SNP guest user. The certificate blob layout is defined in the GHCB
specification. The driver simply treats the blob as a opaque data and
copies it to userspace.

  [ bp: Massage commit message, cast 1st arg of access_ok() ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-46-brijesh.singh@amd.com
---
 Documentation/virt/coco/sevguest.rst  | 23 +++++++-
 drivers/virt/coco/sevguest/sevguest.c | 92 +++++++++++++++++++++++++-
 include/uapi/linux/sev-guest.h        | 13 ++++-
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 4135c14..625de22 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -95,6 +95,29 @@ on the various fields passed in the key derivation request.
 On success, the snp_derived_key_resp.data contains the derived key value. See
 the SEV-SNP specification for further details.
 
+
+2.3 SNP_GET_EXT_REPORT
+----------------------
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in/out): struct snp_ext_report_req
+:Returns (out): struct snp_report_resp on success, -negative on error
+
+The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
+related to the additional certificate data that is returned with the report.
+The certificate data returned is being provided by the hypervisor through the
+SNP_SET_EXT_CONFIG.
+
+The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
+firmware to get the attestation report.
+
+On success, the snp_ext_report_resp.data will contain the attestation report
+and snp_ext_report_req.certs_address will contain the certificate blob. If the
+length of the blob is smaller than expected then snp_ext_report_req.certs_len will
+be updated with the expected value.
+
+See GHCB specification for further detail on how to parse the certificate blob.
+
 Reference
 ---------
 
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 393777b..15afb6c 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -43,6 +43,7 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	void *certs_data;
 	struct snp_guest_crypto *crypto;
 	struct snp_guest_msg *request, *response;
 	struct snp_secrets_page_layout *layout;
@@ -433,6 +434,82 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req;
+	struct snp_report_resp *resp;
+	int ret, npages = 0, resp_len;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	/* userspace does not want certificate data */
+	if (!req.certs_len || !req.certs_address)
+		goto cmd;
+
+	if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
+	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
+		return -EFAULT;
+
+	/*
+	 * Initialize the intermediate buffer with all zeros. This buffer
+	 * is used in the guest request message to get the certs blob from
+	 * the host. If host does not supply any certs in it, then copy
+	 * zeros to indicate that certificate data was not provided.
+	 */
+	memset(snp_dev->certs_data, 0, req.certs_len);
+	npages = req.certs_len >> PAGE_SHIFT;
+cmd:
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!resp)
+		return -ENOMEM;
+
+	snp_dev->input.data_npages = npages;
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+				   SNP_MSG_REPORT_REQ, &req.data,
+				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+
+	/* If certs length is invalid then copy the returned length */
+	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+
+		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+			ret = -EFAULT;
+	}
+
+	if (ret)
+		goto e_free;
+
+	if (npages &&
+	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
+			 req.certs_len)) {
+		ret = -EFAULT;
+		goto e_free;
+	}
+
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		ret = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return ret;
+}
+
 static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
@@ -465,6 +542,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
 	default:
 		break;
 	}
@@ -595,10 +675,14 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!snp_dev->response)
 		goto e_free_request;
 
+	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_free_response;
+
 	ret = -EIO;
 	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
 	if (!snp_dev->crypto)
-		goto e_free_response;
+		goto e_free_cert_data;
 
 	misc = &snp_dev->misc;
 	misc->minor = MISC_DYNAMIC_MINOR;
@@ -608,14 +692,17 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
-		goto e_free_response;
+		goto e_free_cert_data;
 
 	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
+e_free_cert_data:
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 e_free_request:
@@ -629,6 +716,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	deinit_crypto(snp_dev->crypto);
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 598367f..256aaef 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -56,6 +56,16 @@ struct snp_guest_request_ioctl {
 	__u64 fw_err;
 };
 
+struct snp_ext_report_req {
+	struct snp_report_req data;
+
+	/* where to copy the certificate blob */
+	__u64 certs_address;
+
+	/* length of the certificate blob */
+	__u32 certs_len;
+};
+
 #define SNP_GUEST_REQ_IOC_TYPE	'S'
 
 /* Get SNP attestation report */
@@ -64,4 +74,7 @@ struct snp_guest_request_ioctl {
 /* Get a derived key from the root */
 #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
 
+/* Get SNP extended report as defined in the GHCB specification version 2. */
+#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
