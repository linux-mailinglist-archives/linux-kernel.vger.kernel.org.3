Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83355A105
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiFXShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiFXShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CD580507;
        Fri, 24 Jun 2022 11:37:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so4600472edm.13;
        Fri, 24 Jun 2022 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFaSTPA4+vnB1sfsQUKV3lnilUcO33eBAQdm/aUWTyw=;
        b=IjigXTrye7TgR1uPoO+cu/Nvt1/zL9wInvTrH54lK6ryKUbEf15n2ffECt7R160czK
         bsTw1kTAqI2/xcKkqMS1qiYPf5GQ8/QCqgZcP3jGhENb5Wq1PBpH0EDXNA2RFRBjkh3g
         2+Xyotn36s1pKMwRdZ6EQ/jDJWkx92GLUk0wcLWOAfMcEvsFGQu6xH8Xr3lSR9HCdUZU
         s8p7k3uUKDMB494AqL/6jBH+mR6WiA6+VUgzVACytF0roq7Qo3CDONl1sI1cfhu+47ej
         QQ5Zwz767yFMA7b/I7CaJKz/oz705WRlpW37gbLZ5nWLrtU3heRIKG5jNSWyS9BzzNsR
         cD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFaSTPA4+vnB1sfsQUKV3lnilUcO33eBAQdm/aUWTyw=;
        b=YNrqRhB6MVfNBJM2l3507y4oVvjnfPgMP+QFIiF2o1skX8CnY2wTZnhDmKJxfniRk7
         SxobMtWquTVtFUryhBRUH6QVgjSxNKEmnYpvyot6Gf0bSis6vcbo1p3w6UhHahIh6hoo
         jG0+yGnd5DkQFvhWBBf/OMOtsepwgs0F2dcQ4sjnjtsQxiy9Kr/07kBUYdWYq+bFnmpG
         7ShTU5cVu5XNf9rMitwwv08HFz2a33zU/bgV7Rd5KXCyKuMGlzIwE/fG58vK7ioBo5mx
         OXSbxeX94TdDnGYLbLDLCTN0MGyOvTWL90Q2QOipJRwq01EU2uKFB4Q0OdlxGsH/ruVl
         DXsw==
X-Gm-Message-State: AJIora+BqbkvmcowtG46nKJmXn4mf2MxSUhwSw9MmnnVKnxdMlky+OYH
        o3QFKJRsv8d2fMQIwN/x4YRTKAV+Vyw=
X-Google-Smtp-Source: AGRyM1tN9gxDcP6A7nUy5g7kFjosPfFYDaxIlvu2+WhBLN9yNiEbUcPVSFDWLYdzzcSahzS0sps47Q==
X-Received: by 2002:a05:6402:3553:b0:434:ef34:664f with SMTP id f19-20020a056402355300b00434ef34664fmr610148edd.236.1656095821915;
        Fri, 24 Jun 2022 11:37:01 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm1493822ejb.208.2022.06.24.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:37:01 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/4] platform/surface: aggregator: Add helper macros for requests with argument and return value
Date:   Fri, 24 Jun 2022 20:36:39 +0200
Message-Id: <20220624183642.910893-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624183642.910893-1-luzmaximilian@gmail.com>
References: <20220624183642.910893-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper macros for synchronous stack-allocated Surface Aggregator
request with both argument and return value, similar to the current
argument-only and return-value-only ones.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 include/linux/surface_aggregator/controller.h | 125 ++++++++++++++++++
 include/linux/surface_aggregator/device.h     |  36 +++++
 2 files changed, 161 insertions(+)

diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index 50a2b4926c06..d11a1c6e3186 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -469,6 +469,67 @@ struct ssam_request_spec_md {
 		return 0;							\
 	}
 
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_WR() - Define synchronous SAM request function with
+ * both argument and return value.
+ * @name:  Name of the generated function.
+ * @atype: Type of the request's argument.
+ * @rtype: Type of the request's return value.
+ * @spec:  Specification (&struct ssam_request_spec) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by @spec,
+ * with the request taking an argument of type @atype and having a return value
+ * of type @rtype. The generated function takes care of setting up the request
+ * and response structs, buffer allocation, as well as execution of the request
+ * itself, returning once the request has been fully completed. The required
+ * transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, const atype *arg, rtype *ret)``, returning the status
+ * of the request, which is zero on success and negative on failure. The
+ * ``ctrl`` parameter is the controller via which the request is sent. The
+ * request argument is specified via the ``arg`` pointer. The request's return
+ * value is written to the memory pointed to by the ``ret`` parameter.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_WR(name, atype, rtype, spec...)		\
+	static int name(struct ssam_controller *ctrl, const atype *arg, rtype *ret) \
+	{									\
+		struct ssam_request_spec s = (struct ssam_request_spec)spec;	\
+		struct ssam_request rqst;					\
+		struct ssam_response rsp;					\
+		int status;							\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = s.target_id;					\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = s.instance_id;				\
+		rqst.flags = s.flags | SSAM_REQUEST_HAS_RESPONSE;		\
+		rqst.length = sizeof(atype);					\
+		rqst.payload = (u8 *)arg;					\
+										\
+		rsp.capacity = sizeof(rtype);					\
+		rsp.length = 0;							\
+		rsp.pointer = (u8 *)ret;					\
+										\
+		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
+		if (status)							\
+			return status;						\
+										\
+		if (rsp.length != sizeof(rtype)) {				\
+			struct device *dev = ssam_controller_device(ctrl);	\
+			dev_err(dev,						\
+				"rqst: invalid response length, expected %zu, got %zu (tc: %#04x, cid: %#04x)", \
+				sizeof(rtype), rsp.length, rqst.target_category,\
+				rqst.command_id);				\
+			return -EIO;						\
+		}								\
+										\
+		return 0;							\
+	}
+
 /**
  * SSAM_DEFINE_SYNC_REQUEST_MD_N() - Define synchronous multi-device SAM
  * request function with neither argument nor return value.
@@ -613,6 +674,70 @@ struct ssam_request_spec_md {
 		return 0;							\
 	}
 
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_MD_WR() - Define synchronous multi-device SAM
+ * request function with both argument and return value.
+ * @name:  Name of the generated function.
+ * @atype: Type of the request's argument.
+ * @rtype: Type of the request's return value.
+ * @spec:  Specification (&struct ssam_request_spec_md) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by @spec,
+ * with the request taking an argument of type @atype and having a return value
+ * of type @rtype. Device specifying parameters are not hard-coded, but instead
+ * must be provided to the function. The generated function takes care of
+ * setting up the request and response structs, buffer allocation, as well as
+ * execution of the request itself, returning once the request has been fully
+ * completed. The required transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``static int name(struct
+ * ssam_controller *ctrl, u8 tid, u8 iid, const atype *arg, rtype *ret)``,
+ * returning the status of the request, which is zero on success and negative
+ * on failure. The ``ctrl`` parameter is the controller via which the request
+ * is sent, ``tid`` the target ID for the request, and ``iid`` the instance ID.
+ * The request argument is specified via the ``arg`` pointer. The request's
+ * return value is written to the memory pointed to by the ``ret`` parameter.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_MD_WR(name, atype, rtype, spec...)		\
+	static int name(struct ssam_controller *ctrl, u8 tid, u8 iid,		\
+			const atype *arg, rtype *ret)				\
+	{									\
+		struct ssam_request_spec_md s = (struct ssam_request_spec_md)spec; \
+		struct ssam_request rqst;					\
+		struct ssam_response rsp;					\
+		int status;							\
+										\
+		rqst.target_category = s.target_category;			\
+		rqst.target_id = tid;						\
+		rqst.command_id = s.command_id;					\
+		rqst.instance_id = iid;						\
+		rqst.flags = s.flags | SSAM_REQUEST_HAS_RESPONSE;		\
+		rqst.length = sizeof(atype);					\
+		rqst.payload = (u8 *)arg;					\
+										\
+		rsp.capacity = sizeof(rtype);					\
+		rsp.length = 0;							\
+		rsp.pointer = (u8 *)ret;					\
+										\
+		status = ssam_request_sync_onstack(ctrl, &rqst, &rsp, sizeof(atype)); \
+		if (status)							\
+			return status;						\
+										\
+		if (rsp.length != sizeof(rtype)) {				\
+			struct device *dev = ssam_controller_device(ctrl);	\
+			dev_err(dev,						\
+				"rqst: invalid response length, expected %zu, got %zu (tc: %#04x, cid: %#04x)", \
+				sizeof(rtype), rsp.length, rqst.target_category,\
+				rqst.command_id);				\
+			return -EIO;						\
+		}								\
+										\
+		return 0;							\
+	}
+
 
 /* -- Event notifier/callbacks. --------------------------------------------- */
 
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index c418f7f2732d..6cf7e80312d5 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -483,6 +483,42 @@ static inline void ssam_remove_clients(struct device *dev) {}
 				    sdev->uid.instance, ret);		\
 	}
 
+/**
+ * SSAM_DEFINE_SYNC_REQUEST_CL_WR() - Define synchronous client-device SAM
+ * request function with argument and return value.
+ * @name:  Name of the generated function.
+ * @atype: Type of the request's argument.
+ * @rtype: Type of the request's return value.
+ * @spec:  Specification (&struct ssam_request_spec_md) defining the request.
+ *
+ * Defines a function executing the synchronous SAM request specified by @spec,
+ * with the request taking an argument of type @atype and having a return value
+ * of type @rtype. Device specifying parameters are not hard-coded, but instead
+ * are provided via the client device, specifically its UID, supplied when
+ * calling this function. The generated function takes care of setting up the
+ * request struct, buffer allocation, as well as execution of the request
+ * itself, returning once the request has been fully completed. The required
+ * transport buffer will be allocated on the stack.
+ *
+ * The generated function is defined as ``static int name(struct ssam_device
+ * *sdev, const atype *arg, rtype *ret)``, returning the status of the request,
+ * which is zero on success and negative on failure. The ``sdev`` parameter
+ * specifies both the target device of the request and by association the
+ * controller via which the request is sent. The request's argument is
+ * specified via the ``arg`` pointer. The request's return value is written to
+ * the memory pointed to by the ``ret`` parameter.
+ *
+ * Refer to ssam_request_sync_onstack() for more details on the behavior of
+ * the generated function.
+ */
+#define SSAM_DEFINE_SYNC_REQUEST_CL_WR(name, atype, rtype, spec...)		\
+	SSAM_DEFINE_SYNC_REQUEST_MD_WR(__raw_##name, atype, rtype, spec)	\
+	static int name(struct ssam_device *sdev, const atype *arg, rtype *ret)	\
+	{									\
+		return __raw_##name(sdev->ctrl, sdev->uid.target,		\
+				    sdev->uid.instance, arg, ret);		\
+	}
+
 
 /* -- Helpers for client-device notifiers. ---------------------------------- */
 
-- 
2.36.1

