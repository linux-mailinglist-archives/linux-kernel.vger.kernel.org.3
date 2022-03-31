Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBECB4ED42F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiCaGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiCaGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:53:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248045798
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:51:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so1580921pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=30AsFn9tBa39albgpW8owhNlET/UwI3suCIxLN0538E=;
        b=aISTkM1lTytIC5XciL5Gdw3esFpeQO0JF9BLnenycv0BR1pRKURn1SDSAGxL/i18Bi
         UTcv/QpWxAVvXOh15e/JEFMetEgzbYVgf0jtF0dy+Jna7Dih6zQfT7Cz8w2utnnY+biW
         xsGzhEMFcjyg2tkpX9MUc2L8Lo7RuoabyZo4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=30AsFn9tBa39albgpW8owhNlET/UwI3suCIxLN0538E=;
        b=vieON6Txrak/kPbK3x5/HNFZgO/jErNLLS4YsYRUUVkIO5hiXXCZSw1mH7NutNmn1p
         JSppgh7+evuXSbHL5qBzWpphIcuKEMU5dbrz5v4nh8kb/Y504dk07PYmYkyisRdn1Z2v
         kPCrNAzYNm7K7fqNHfMbsoYYFciYteyuYxJV/OnPPrAxzGIwQ0gmjA/gkOmjUaTVp+YA
         w4pjUWejRWf42MOr4i7bXD2dBmRa68QeSxX6Hmpv51HatLAb2/8dCmIaoqvdQoOJq5hG
         bSDB/JDmWFL2dACF24+lXI/jrJu35lkMGOFe7cmUNzO2mXKvlJJnp9Oy1XEaKWTlcPIL
         dUCg==
X-Gm-Message-State: AOAM533rq96nYLFuvkIpGqRe7OD2jd7+a1kmoyhkcpeFIKMR072lVbvO
        4/hOYl04aUuRkJsrFaJLO6nEyV0wqzWf71NdbvoFFXEegVMNCjXjY/HstEJEuVLr++c4hJuY6Pt
        yIgI9yxMEAJ60zlqdhIihLxIwYG0+1DptUJL8CY868tgfQKe2XrCP/+rfB1efbDOoV/xD3rt7J4
        0lffXdM+EOyS+Umv2xbQ==
X-Google-Smtp-Source: ABdhPJxdVZtj34ZTwSQV3EALcdmgE86FlSzbov8E3LPrfqilVifatQa9KDUjG4YPl3j7I7AlvP4Npg==
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id q9-20020a056a00088900b004e0dcc35e06mr3963720pfj.29.1648709480671;
        Wed, 30 Mar 2022 23:51:20 -0700 (PDT)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id f30-20020a63755e000000b00381f6b7ef30sm21251753pgn.54.2022.03.30.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 23:51:20 -0700 (PDT)
From:   alexander komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com,
        alexander komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH] Calculate the monotonic clock from the timespec clock to generate PPS elapsed real-time event value and stores the result into /sys/class/pps/pps0/assert_elapsed. Because we have requirements to make sure the delta between standard time, say the GPS Time, and elapsedRealtime < 1 millisecond, regular linux clock timestamp is not enough for our use case. The pin PPS will generate elapsedRealtime event at 1 sec boundary which is an exact value of the monotonic clock from the kernel PPS driver (/sys/class/pps/pps0/assert_elapsed). Whenever AP receives this pulse, kernel's pps driver timestamp this elapsedRealtime event and let this time available via sysfs node (/sys/class/pps/pps0/assert_elapsed) or the IOCTL call.
Date:   Wed, 30 Mar 2022 23:51:16 -0700
Message-Id: <20220331065117.250375-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fc1b6505db7e16c0"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fc1b6505db7e16c0
Content-Transfer-Encoding: 8bit

---
 Documentation/ABI/testing/sysfs-pps | 24 ++++++++++++++++++
 drivers/pps/kapi.c                  | 38 ++++++++++++++++++++++++++---
 drivers/pps/sysfs.c                 | 33 +++++++++++++++++++++++++
 include/linux/pps_kernel.h          |  2 ++
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
index 25028c7bc37d..054617abeebd 100644
--- a/Documentation/ABI/testing/sysfs-pps
+++ b/Documentation/ABI/testing/sysfs-pps
@@ -1,3 +1,27 @@
+What:		/sys/class/pps/pps0/assert_elapsed
+Date:		October 2021
+Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
+Description:
+		The /sys/class/pps/ppsX/assert_elapsed file reports the elapsed real-time assert events
+		and the elapsed real-time assert sequence number of the X-th source in the form:
+
+			<secs>.<nsec>#<sequence>
+
+		If the source has no elapsed real-time assert events the content of this file
+		is empty.
+
+What:		/sys/class/pps/ppsX/clear_elapsed
+Date:		October 2021
+Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
+Description:
+		The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed real-time clear events
+		and the elapsed real-time clear sequence number of the X-th source in the form:
+
+			<secs>.<nsec>#<sequence>
+
+		If the source has no elapsed real-time clear events the content of this file
+		is empty.
+
 What:		/sys/class/pps/
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..6d1fbe4a8c40 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -23,6 +23,26 @@
 /*
  * Local functions
  */
+ #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
+
+/**
+ * clock_gettime - get the monotonic clock in pps_ktime format
+ * @kt:		pointer to the pps_ktime to be set to raw monotonic time
+ *
+ * The function calculates the monotonic clock from the timespec clock
+ * and stores the result in pps_ktime format in the variable pointed to by @kt.
+ *
+ * The function returns the monotonic clock normalized format in nanosec.
+ */
+static __u64 clock_gettime(struct pps_ktime *kt)
+{
+	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
+
+	ktime_get_boottime_ts64(&ts);
+	kt->sec = ts.tv_sec;
+	kt->nsec = ts.tv_nsec;
+	return (__u64) ts.tv_sec * NANOSEC_PER_SEC + ts.tv_nsec;
+}
 
 static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
 {
@@ -162,11 +182,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	unsigned long flags;
 	int captured = 0;
 	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
+	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
 
 	/* check event type */
 	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
+	clock_gettime(&ts_real_elapsed);
+	dev_dbg(pps->dev, "PPS event (monotonic) at %lld.%09d\n",
+			(s64)ts_real_elapsed.sec, ts_real_elapsed.nsec);
 
-	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
+	dev_dbg(pps->dev, "PPS event (timestamp) at %lld.%09ld\n",
 			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
 
 	timespec_to_pps_ktime(&ts_real, ts->ts_real);
@@ -181,11 +205,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	pps->current_mode = pps->params.mode;
 	if (event & pps->params.mode & PPS_CAPTUREASSERT) {
 		/* We have to add an offset? */
-		if (pps->params.mode & PPS_OFFSETASSERT)
+		if (pps->params.mode & PPS_OFFSETASSERT) {
+			pps_add_offset(&ts_real_elapsed,
+					&pps->params.assert_off_tu);
 			pps_add_offset(&ts_real,
 					&pps->params.assert_off_tu);
+		}
 
 		/* Save the time stamp */
+		pps->assert_elapsed_tu = ts_real_elapsed;
 		pps->assert_tu = ts_real;
 		pps->assert_sequence++;
 		dev_dbg(pps->dev, "capture assert seq #%u\n",
@@ -195,11 +223,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	}
 	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
 		/* We have to add an offset? */
-		if (pps->params.mode & PPS_OFFSETCLEAR)
+		if (pps->params.mode & PPS_OFFSETCLEAR)	{
+			pps_add_offset(&ts_real_elapsed,
+					&pps->params.clear_off_tu);
 			pps_add_offset(&ts_real,
 					&pps->params.clear_off_tu);
+		}
 
 		/* Save the time stamp */
+		pps->clear_elapsed_tu = ts_real_elapsed;
 		pps->clear_tu = ts_real;
 		pps->clear_sequence++;
 		dev_dbg(pps->dev, "capture clear seq #%u\n",
diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
index 134bc33f6ad0..97721cb01695 100644
--- a/drivers/pps/sysfs.c
+++ b/drivers/pps/sysfs.c
@@ -29,6 +29,21 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(assert);
 
+static ssize_t assert_elapsed_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTUREASSERT))
+		return 0;
+
+	return sprintf(buf, "%lld.%09d#%d\n",
+			(long long) pps->assert_elapsed_tu.sec,
+			pps->assert_elapsed_tu.nsec,
+			pps->assert_sequence);
+}
+static DEVICE_ATTR_RO(assert_elapsed);
+
 static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -43,6 +58,22 @@ static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(clear);
 
+static ssize_t clear_elapsed_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTURECLEAR))
+		return 0;
+
+	return sprintf(buf, "%lld.%09d#%d\n",
+			(long long) pps->clear_elapsed_tu.sec,
+			pps->clear_elapsed_tu.nsec,
+			pps->clear_sequence);
+}
+static DEVICE_ATTR_RO(clear_elapsed);
+
 static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -81,7 +112,9 @@ static DEVICE_ATTR_RO(path);
 
 static struct attribute *pps_attrs[] = {
 	&dev_attr_assert.attr,
+	&dev_attr_assert_elapsed.attr,
 	&dev_attr_clear.attr,
+	&dev_attr_clear_elapsed.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_echo.attr,
 	&dev_attr_name.attr,
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..1fecaaf4c8b9 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -47,6 +47,8 @@ struct pps_device {
 
 	__u32 assert_sequence;			/* PPS assert event seq # */
 	__u32 clear_sequence;			/* PPS clear event seq # */
+	struct pps_ktime assert_elapsed_tu; /* PPS elapsed rt assert seq # */
+	struct pps_ktime clear_elapsed_tu;  /* PPS elapsed rt clear event seq */
 	struct pps_ktime assert_tu;
 	struct pps_ktime clear_tu;
 	int current_mode;			/* PPS mode at event time */
-- 
2.25.1


--000000000000fc1b6505db7e16c0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQegYJKoZIhvcNAQcCoIIQazCCEGcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3RMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVkwggRBoAMCAQICDHYIL0hy7FtCa0iawzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNDMzNTVaFw0yMjA5MDEwNzU5MzNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUFsZXggS29tcmFrb3YxLjAsBgkqhkiG9w0B
CQEWH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC9plVHzugCEzdkg+8eZF4DLPZ5fqspSSVbjMcgMDJQcAR76/SGGJnSJiHOj/rn
okK4r4HXW8cTMmw/ePqLs+eX7+h2TlrLFdwnPs6ThKSnKe7aNihCrk9rF+WyTTX/VrqyKPYICkp0
/XhRuIlIO0cP979rZRsxD4LKmC6x1msVkkM7JxkWhkktTzQwowAemtij6uzfYeh5BzQd2+LaWp8g
ZX2NhNnwh9gNMFxHdE5c6+G3LG7AHwFOPA6G1TuzZ35urQXh4HWGbGoCJPszKLgccfOBBHYaXyo6
yiBn77ZVlo89La3IlKW/J8Bg1ZiYHcR6RtGGylxCCKgFDdESfV03AgMBAAGjggHgMIIB3DAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCoGA1UdEQQjMCGBH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFElfe2CJ
evQgM+vs7qmUiI/AGUBAMA0GCSqGSIb3DQEBCwUAA4IBAQCmTMsF9VHjT0L2ycGjBg8eb/+aTBhL
U6r4e4vaGj/xmDd1cWfvz4brxodjpmuSnjfyWvU/odcNIepLv17Xc91OiZBWGYgr4jNViUqunvaH
DCnJlLbrD88ITE1uo7OCdlN/SS+Sskp2dDvL/Xlyorb+PaS7/AaIwEmuGyJv2uv1wQ+UZzPXXo1B
vOM4N+PxiEKCkmmYhfeSVye92Bta6vjf0b+oDE2JT82+D+9nAfiyJ9P/SRVTTvLlSzcO2fqX6GOc
37xY9F5HGjunD+cc5mqKM/r5PXyM/LEzWjdU1lVUVuvLRerUn+GNFgAPzpksTVYDv2kuseIFwRrF
845kQxaRMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
dggvSHLsW0JrSJrDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBuC5wnhLnsnAKm
Jp2912WHu/LdM1aDcgvLauGVP+xXdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMjAzMzEwNjUxMjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhz0Lbf2NL1nko4RmgJ5DLCDQ4JkufYnf
abuJh+5+f29JyH2PDKpVii9YBe/Zad6X+C3dHFSw4CBHElX2fOYFJsbOISXFfb69JHpU+r2miOL0
1HIMV9wmG/aI5Vy43HVEwPcVQEto4JYNmisWyIsVMbFKrfGbNalM49iVHpAGLn3Qc9KOIF0E3+xy
38uzuvNx86VHmuuFrlbuKSP5Qao58zQL3zXBldMh9NDyQGpu0y/UNMDj4C4gwYyRZ7RPB1CmNL9d
Pc/OzsnMqmSqYj7Xj+LZNQR6AN6BaeZte99s6F6gh7bbCUsVE0DsTXY5xhl+kU1+89vPjYTpMzA8
GbNYuA==
--000000000000fc1b6505db7e16c0--
